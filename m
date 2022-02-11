Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69400C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 22:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354004AbiBKWO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 17:14:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiBKWO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:14:56 -0500
X-Greylist: delayed 524 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 14:14:54 PST
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ADDD42
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:14:54 -0800 (PST)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nIe3F-0004nV-QK; Fri, 11 Feb 2022 17:06:01 -0500
Date:   Fri, 11 Feb 2022 17:05:57 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm: clean up hwpoison page cache page in fault path
Message-ID: <20220211170557.7964a301@imladris.surriel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the page offlining code can leave behind a hwpoisoned clean
page cache page. This can lead to programs being killed over and over
and over again as they fault in the hwpoisoned page, get killed, and
then get re-spawned by whatever wanted to run them.
    
This is particularly embarrassing when the page was offlined due to
having too many corrected memory errors. Now we are killing tasks
due to them trying to access memory that probably isn't even corrupted.
    
This problem can be avoided by invalidating the page from the page
fault handler, which already has a branch for dealing with these
kinds of pages. With this patch we simply pretend the page fault
was successful if the page was invalidated, return to userspace,
incur another page fault, read in the file from disk (to a new
memory page), and then everything works again.
    
Signed-off-by: Rik van Riel <riel@surriel.com>

diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..2300358e268c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3871,11 +3871,16 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 		return ret;
 
 	if (unlikely(PageHWPoison(vmf->page))) {
-		if (ret & VM_FAULT_LOCKED)
+		int poisonret = VM_FAULT_HWPOISON;
+		if (ret & VM_FAULT_LOCKED) {
+			/* Retry if a clean page was removed from the cache. */
+			if (invalidate_inode_page(vmf->page))
+				poisonret = 0;
 			unlock_page(vmf->page);
+		}
 		put_page(vmf->page);
 		vmf->page = NULL;
-		return VM_FAULT_HWPOISON;
+		return poisonret;
 	}
 
 	if (unlikely(!(ret & VM_FAULT_LOCKED)))


-- 
All rights reversed.
