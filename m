Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0579C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386080AbiDLIyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359389AbiDLHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:43:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5C2C679;
        Tue, 12 Apr 2022 00:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3685B81B58;
        Tue, 12 Apr 2022 07:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B07AC385A1;
        Tue, 12 Apr 2022 07:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649748124;
        bh=6XkHVmwmwN5hcX4U9xQPmanqLhUuQjq9xg1RnT15PKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjfuMFyLb+/f8L4REeERkHGUvcqG+yYCp1tdbiUEfomH9kv4+RUUn4AlW+LQ+g6XX
         Fvt4JG8FKMMKDXYub8zLx07OBoxkQfot9hBpbHoPc+a8lOVZlGfpnzZtP66VVf+DbQ
         mcnOsuOYYpjEV4xW2pe9Wrbfn57OETt5Mm8wwxg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.17 278/343] io_uring: implement compat handling for IORING_REGISTER_IOWQ_AFF
Date:   Tue, 12 Apr 2022 08:31:36 +0200
Message-Id: <20220412062959.347659588@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Syromiatnikov <esyr@redhat.com>

commit 0f5e4b83b37a96e3643951588ed7176b9b187c0a upstream.

Similarly to the way it is done im mbind syscall.

Cc: stable@vger.kernel.org # 5.14
Fixes: fe76421d1da1dcdb ("io_uring: allow user configurable IO thread CPU affinity")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/io_uring.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -10860,7 +10860,15 @@ static __cold int io_register_iowq_aff(s
 	if (len > cpumask_size())
 		len = cpumask_size();
 
-	if (copy_from_user(new_mask, arg, len)) {
+	if (in_compat_syscall()) {
+		ret = compat_get_bitmap(cpumask_bits(new_mask),
+					(const compat_ulong_t __user *)arg,
+					len * 8 /* CHAR_BIT */);
+	} else {
+		ret = copy_from_user(new_mask, arg, len);
+	}
+
+	if (ret) {
 		free_cpumask_var(new_mask);
 		return -EFAULT;
 	}


