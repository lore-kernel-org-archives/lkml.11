Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B655C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiBUJij (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:38:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349708AbiBUJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:30:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2325C59;
        Mon, 21 Feb 2022 01:13:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3861CE0E86;
        Mon, 21 Feb 2022 09:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD92C339C8;
        Mon, 21 Feb 2022 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645434786;
        bh=hUv1vw7+SG1GUc+ciH6Lke2YWRLHdxDggbqlY0eKXdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbRMKrhAvz44L25CsWeU4MxIC8OijPRIZGSVLPKLXWZh/fcKGmPZLG0zOaX34pYX5
         r3Oh/dmgy/qnPfgQPxV04iBHbJv8dVdjX3QYov++XseUtOQJrNOs2mZVuUI9FScJq5
         mDWzybyjCVGL0FQk9cjwjFDI3HoZUv28oOatbvtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.15 131/196] NFS: Remove an incorrect revalidation in nfs4_update_changeattr_locked()
Date:   Mon, 21 Feb 2022 09:49:23 +0100
Message-Id: <20220221084935.311257381@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084930.872957717@linuxfoundation.org>
References: <20220221084930.872957717@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 9d047bf68fe8cdb4086deaf4edd119731a9481ed upstream.

In nfs4_update_changeattr_locked(), we don't need to set the
NFS_INO_REVAL_PAGECACHE flag, because we already know the value of the
change attribute, and we're already flagging the size. In fact, this
forces us to revalidate the change attribute a second time for no good
reason.
This extra flag appears to have been introduced as part of the xattr
feature, when update_changeattr_locked() was converted for use by the
xattr code.

Fixes: 1b523ca972ed ("nfs: modify update_changeattr to deal with regular files")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1232,8 +1232,7 @@ nfs4_update_changeattr_locked(struct ino
 				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
 				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
 				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
-				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR |
-				NFS_INO_REVAL_PAGECACHE;
+				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR;
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	}
 	nfsi->attrtimeo_timestamp = jiffies;


