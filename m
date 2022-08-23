Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB3C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbiHWIUA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242746AbiHWIPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:15:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCFF6DAD8;
        Tue, 23 Aug 2022 01:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EF65B81C26;
        Tue, 23 Aug 2022 08:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640A9C433D6;
        Tue, 23 Aug 2022 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242222;
        bh=gl2ec1/9WIGA+Cbo3C9Q12gKyFZ9vUECTlF+qnQ3z+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uU+ybIjSYGpI064SIikmBvCp+h+rrUIVYn/8hoRibGV5BJrEjLS8dhHvDGn770nHL
         APn8N/w77wTousdPb5xjcEKblpEeNHhAyCVyyba3sXnZQyAlTGcHO+DZq/FQWUtV1Z
         DzRFREs6Vziq3zJ6qKssCNzK2auPqgrcAuKxa2IY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.9 038/101] fuse: limit nsec
Date:   Tue, 23 Aug 2022 10:03:11 +0200
Message-Id: <20220823080036.019985254@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080034.579196046@linuxfoundation.org>
References: <20220823080034.579196046@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit 47912eaa061a6a81e4aa790591a1874c650733c0 upstream.

Limit nanoseconds to 0..999999999.

Fixes: d8a5ba45457e ("[PATCH] FUSE - core")
Cc: <stable@vger.kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -173,6 +173,12 @@ void fuse_change_attributes_common(struc
 	inode->i_uid     = make_kuid(&init_user_ns, attr->uid);
 	inode->i_gid     = make_kgid(&init_user_ns, attr->gid);
 	inode->i_blocks  = attr->blocks;
+
+	/* Sanitize nsecs */
+	attr->atimensec = min_t(u32, attr->atimensec, NSEC_PER_SEC - 1);
+	attr->mtimensec = min_t(u32, attr->mtimensec, NSEC_PER_SEC - 1);
+	attr->ctimensec = min_t(u32, attr->ctimensec, NSEC_PER_SEC - 1);
+
 	inode->i_atime.tv_sec   = attr->atime;
 	inode->i_atime.tv_nsec  = attr->atimensec;
 	/* mtime from server may be stale due to local buffered write */


