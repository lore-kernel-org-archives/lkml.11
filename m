Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78386C35278
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiCNMcf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243933AbiCNMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249D813CF7;
        Mon, 14 Mar 2022 05:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA7E608C4;
        Mon, 14 Mar 2022 12:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D4C340E9;
        Mon, 14 Mar 2022 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647260322;
        bh=AUqtvabMwOT8H1tChuw/4DbeorIaoD6A+b5KC2+sjwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l35zoC+GVveTbTDAYsb+joju3ZKB9mXu5XdkTt0SjmVIMJ9iJN5nMpcSeJexxkVCX
         89tVo3ODpFNXBf0n4NHqavaGQi0120uvKbxnYY2lotEvhJhwlXRCtdt28vRhXuR31k
         qXZ8wZ3tAFuFJtQuuRlWadPO6rPASWOXYcPyOhCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.16 107/121] watch_queue: Fix to release page in ->release()
Date:   Mon, 14 Mar 2022 12:54:50 +0100
Message-Id: <20220314112747.097751086@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314112744.120491875@linuxfoundation.org>
References: <20220314112744.120491875@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit c1853fbadcba1497f4907971e7107888e0714c81 upstream.

When a pipe ring descriptor points to a notification message, the
refcount on the backing page is incremented by the generic get function,
but the release function, which marks the bitmap, doesn't drop the page
ref.

Fix this by calling generic_pipe_buf_release() at the end of
watch_queue_pipe_buf_release().

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/watch_queue.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -54,6 +54,7 @@ static void watch_queue_pipe_buf_release
 	bit += page->index;
 
 	set_bit(bit, wqueue->notes_bitmap);
+	generic_pipe_buf_release(pipe, buf);
 }
 
 // No try_steal function => no stealing


