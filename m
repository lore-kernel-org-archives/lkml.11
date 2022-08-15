Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DB8C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 21:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349563AbiHOVpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349506AbiHOVlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F35B78F;
        Mon, 15 Aug 2022 12:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5005C61129;
        Mon, 15 Aug 2022 19:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A69C433C1;
        Mon, 15 Aug 2022 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660591749;
        bh=i/IqNC9sKyzc2Gi0Ic4dqxmktUixRmto/+KsH9OoTSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXfKz6ZwIgv/rlGJBMdlWdMJRQQm8Wy8t8kkduTYAYeQqrRBjxnIsKje/LPDq0RBE
         8kfhnuN9sWLRk1YxCIJFhf9Zdz53WdcvdPf5pcgjjTS5zE41zMXhQg3N4oq7ObVguY
         l8Gwlky7u7QldNbUf0IDx68YLazHxZuWuLAkGKtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.19 0003/1157] Revert "pNFS: nfs3_set_ds_client should set NFS_CS_NOPING"
Date:   Mon, 15 Aug 2022 19:49:19 +0200
Message-Id: <20220815180439.604983378@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 9597152d98840c2517230740952df97cfcc07e2f upstream.

This reverts commit c6eb58435b98bd843d3179664a0195ff25adb2c3.
If a transport is down, then we want to fail over to other transports if
they are listed in the GETDEVICEINFO reply.

Fixes: c6eb58435b98 ("pNFS: nfs3_set_ds_client should set NFS_CS_NOPING")
Cc: stable@vger.kernel.org # 5.11.x
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs3client.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -108,7 +108,6 @@ struct nfs_client *nfs3_set_ds_client(st
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
-	__set_bit(NFS_CS_NOPING, &cl_init.init_flags);
 	__set_bit(NFS_CS_DS, &cl_init.init_flags);
 
 	/* Use the MDS nfs_client cl_ipaddr. */


