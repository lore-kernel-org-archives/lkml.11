Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCA3C38A2E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 12:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391496AbiBGMCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386791AbiBGLhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:37:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF85C043188;
        Mon,  7 Feb 2022 03:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA996091A;
        Mon,  7 Feb 2022 11:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE55C004E1;
        Mon,  7 Feb 2022 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644233819;
        bh=djEWEpnDCk7CcnGly2CXbCMMBRAixEGBx4BvC4JPjCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Apvbl6NMzg4LjzuN/CnA6CrezgJeMBL1lvWsGDMtmpY7DPCW3g6o16VItoiqHWKle
         9EIttKGVBCHVQ/AoCPSP1RAwDUrg67S+QpbRDESFfPKOh6by5REbhAWXjyyvd6TyjX
         on4DPoNxD2AnCZi+LGqvWxj9oSwiahcZO7sqninY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>, Tom Rix <trix@redhat.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.16 097/126] btrfs: fix use of uninitialized variable at rm device ioctl
Date:   Mon,  7 Feb 2022 12:07:08 +0100
Message-Id: <20220207103807.431628136@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103804.053675072@linuxfoundation.org>
References: <20220207103804.053675072@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

commit 37b4599547e324589e011c20f74b021d6d25cb7f upstream.

Clang static analysis reports this problem
ioctl.c:3333:8: warning: 3rd function call argument is an
  uninitialized value
    ret = exclop_start_or_cancel_reloc(fs_info,

cancel is only set in one branch of an if-check and is always used.  So
initialize to false.

Fixes: 1a15eb724aae ("btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3310,7 +3310,7 @@ static long btrfs_ioctl_rm_dev(struct fi
 	struct block_device *bdev = NULL;
 	fmode_t mode;
 	int ret;
-	bool cancel;
+	bool cancel = false;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;


