Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E19C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 20:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359033AbiFGUWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 16:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355966AbiFGTbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC7B590A2;
        Tue,  7 Jun 2022 11:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C7AF61903;
        Tue,  7 Jun 2022 18:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB0CC341C6;
        Tue,  7 Jun 2022 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654625521;
        bh=eYiL3sMN+v2IyVHBMa9mVpXkpwYerhGeO1ZaE+IRYH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYL2xNOzB7+wnHn8kp+l3S8ksvuZ78W7GR34fsvPZ4Y4x37YD5FYm7N2BopfHv4BU
         f1i/PI5CiFL2KofXSI00GIEKsgUjlOIabQ5vzqF5Fevnf6tD8ML1coqG4y/z4uTBgg
         nlPA1gA/0LInNWxV6rqxe7FH4LStfm7ilLW7XaE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.17 049/772] btrfs: zoned: fix comparison of alloc_offset vs meta_write_pointer
Date:   Tue,  7 Jun 2022 18:54:01 +0200
Message-Id: <20220607164950.482991486@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naohiro Aota <naohiro.aota@wdc.com>

commit aa9ffadfcae33e611d8c2d476bcc2aa0d273b587 upstream.

The block_group->alloc_offset is an offset from the start of the block
group. OTOH, the ->meta_write_pointer is an address in the logical
space. So, we should compare the alloc_offset shifted with the
block_group->start.

Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
CC: stable@vger.kernel.org # 5.16+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/zoned.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1863,7 +1863,7 @@ int btrfs_zone_finish(struct btrfs_block
 	/* Check if we have unwritten allocated space */
 	if ((block_group->flags &
 	     (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)) &&
-	    block_group->alloc_offset > block_group->meta_write_pointer) {
+	    block_group->start + block_group->alloc_offset > block_group->meta_write_pointer) {
 		spin_unlock(&block_group->lock);
 		return -EAGAIN;
 	}


