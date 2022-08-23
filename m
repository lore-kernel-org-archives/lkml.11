Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8A8C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 11:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349786AbiHWLSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 07:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357535AbiHWLQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:16:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B76BCCFB;
        Tue, 23 Aug 2022 02:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B004B8105C;
        Tue, 23 Aug 2022 09:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87864C433C1;
        Tue, 23 Aug 2022 09:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661246310;
        bh=xU6UoLaBrAZoUVuMP2Ai1TCNiw+qtZWEPe65ArGFS6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGuJa5BT7BFhSxgyk2xobHvPQQCzRDBtnxqKaDJm9VHffaLwUe5JD90dIjnOvbsXA
         QeGNQI7YkWDmCSaDo7g4ew0YrRjfMSXxH4uiai5MRzMsiCbROBxXJfmrbPI1Jq6oty
         3zkyt9fHp/hRfylQce3M30Q+R6Mrx6CwEhb7AIHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hongbo Yin <yinhongbo@bytedance.com>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Tianci Zhang <zhangtianci.1997@bytedance.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.4 028/389] ovl: drop WARN_ON() dentry is NULL in ovl_encode_fh()
Date:   Tue, 23 Aug 2022 10:21:46 +0200
Message-Id: <20220823080116.867382766@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080115.331990024@linuxfoundation.org>
References: <20220823080115.331990024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

commit dd524b7f317de8d31d638cbfdc7be4cf9b770e42 upstream.

Some code paths cannot guarantee the inode have any dentry alias. So
WARN_ON() all !dentry may flood the kernel logs.

For example, when an overlayfs inode is watched by inotifywait (1), and
someone is trying to read the /proc/$(pidof inotifywait)/fdinfo/INOTIFY_FD,
at that time if the dentry has been reclaimed by kernel (such as
echo 2 > /proc/sys/vm/drop_caches), there will be a WARN_ON(). The
printed call stack would be like:

    ? show_mark_fhandle+0xf0/0xf0
    show_mark_fhandle+0x4a/0xf0
    ? show_mark_fhandle+0xf0/0xf0
    ? seq_vprintf+0x30/0x50
    ? seq_printf+0x53/0x70
    ? show_mark_fhandle+0xf0/0xf0
    inotify_fdinfo+0x70/0x90
    show_fdinfo.isra.4+0x53/0x70
    seq_show+0x130/0x170
    seq_read+0x153/0x440
    vfs_read+0x94/0x150
    ksys_read+0x5f/0xe0
    do_syscall_64+0x59/0x1e0
    entry_SYSCALL_64_after_hwframe+0x44/0xa9

So let's drop WARN_ON() to avoid kernel log flooding.

Reported-by: Hongbo Yin <yinhongbo@bytedance.com>
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Tianci Zhang <zhangtianci.1997@bytedance.com>
Fixes: 8ed5eec9d6c4 ("ovl: encode pure upper file handles")
Cc: <stable@vger.kernel.org> # v4.16
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/export.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -274,7 +274,7 @@ static int ovl_encode_fh(struct inode *i
 		return FILEID_INVALID;
 
 	dentry = d_find_any_alias(inode);
-	if (WARN_ON(!dentry))
+	if (!dentry)
 		return FILEID_INVALID;
 
 	type = ovl_dentry_to_fh(dentry, fid, max_len);


