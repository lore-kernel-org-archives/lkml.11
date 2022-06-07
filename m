Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D89C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 20:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359156AbiFGUXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355770AbiFGTao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:30:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5081A43C8;
        Tue,  7 Jun 2022 11:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7418FB81F38;
        Tue,  7 Jun 2022 18:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46CDC385A5;
        Tue,  7 Jun 2022 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654625516;
        bh=GHSWOLtaRIxGcfDoMTvsX1OVEgJYxZloovcbfd7Oric=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mr+3p2Pnv/hkhS0l5Sw/rcjk4YGIyMf9JQ75pTkDj67kP/2otndFwMKBc9rn9etqK
         IqXs3fUcfTsE0l0gCE5s02vUYxjZcoyUCzg+wylGzCL5k3jCR+NTwIn9MSpcPrrNOO
         3s4VylXWpuul0n9/BMt0QE61aCUZ0hd3cQ30zGU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.17 047/772] btrfs: zoned: zone finish unused block group
Date:   Tue,  7 Jun 2022 18:53:59 +0200
Message-Id: <20220607164950.422368315@linuxfoundation.org>
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

commit 74e91b12b11560f01d120751d99d91d54b265d3d upstream.

While the active zones within an active block group are reset, and their
active resource is released, the block group itself is kept in the active
block group list and marked as active. As a result, the list will contain
more than max_active_zones block groups. That itself is not fatal for the
device as the zones are properly reset.

However, that inflated list is, of course, strange. Also, a to-appear
patch series, which deactivates an active block group on demand, gets
confused with the wrong list.

So, fix the issue by finishing the unused block group once it gets
read-only, so that we can release the active resource in an early stage.

Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
CC: stable@vger.kernel.org # 5.16+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1367,6 +1367,14 @@ void btrfs_delete_unused_bgs(struct btrf
 			goto next;
 		}
 
+		ret = btrfs_zone_finish(block_group);
+		if (ret < 0) {
+			btrfs_dec_block_group_ro(block_group);
+			if (ret == -EAGAIN)
+				ret = 0;
+			goto next;
+		}
+
 		/*
 		 * Want to do this before we do anything else so we can recover
 		 * properly if we fail to join the transaction.


