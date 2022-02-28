Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2FAC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 17:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiB1Rzs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbiB1Rww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:52:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A393982;
        Mon, 28 Feb 2022 09:39:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CBF2614CC;
        Mon, 28 Feb 2022 17:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85433C340E7;
        Mon, 28 Feb 2022 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646069994;
        bh=p9ckdDtQYt8cam5k/4hyLTvHsay93JN2BiHA02yx+Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnFV9hrv6mbx6/QC50gX8SxcNqqqxMfZ+ek0o3TrIZT8SI9JD1wYj0x7ccp7rHvqK
         tXK2rPaRqPcKUIYV5VoEwjSNyjppE+/NuegOtOt0fFwVyOPcGVeXFBmkq7QaVsJzPX
         PXjrfUBOBNnHye3uR0ZCQ8x3XBfsEHd4yXGdP8to=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meir Lichtinger <meirl@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 5.15 049/139] net/mlx5: Update the list of the PCI supported devices
Date:   Mon, 28 Feb 2022 18:23:43 +0100
Message-Id: <20220228172352.849780237@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228172347.614588246@linuxfoundation.org>
References: <20220228172347.614588246@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meir Lichtinger <meirl@nvidia.com>

commit f908a35b22180c4da64cf2647e4f5f0cd3054da7 upstream.

Add the upcoming BlueField-4 and ConnectX-8 device IDs.

Fixes: 2e9d3e83ab82 ("net/mlx5: Update the list of the PCI supported devices")
Signed-off-by: Meir Lichtinger <meirl@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1762,10 +1762,12 @@ static const struct pci_device_id mlx5_c
 	{ PCI_VDEVICE(MELLANOX, 0x101e), MLX5_PCI_DEV_IS_VF},	/* ConnectX Family mlx5Gen Virtual Function */
 	{ PCI_VDEVICE(MELLANOX, 0x101f) },			/* ConnectX-6 LX */
 	{ PCI_VDEVICE(MELLANOX, 0x1021) },			/* ConnectX-7 */
+	{ PCI_VDEVICE(MELLANOX, 0x1023) },			/* ConnectX-8 */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2dc) },			/* BlueField-3 integrated ConnectX-7 network controller */
+	{ PCI_VDEVICE(MELLANOX, 0xa2df) },			/* BlueField-4 integrated ConnectX-8 network controller */
 	{ 0, }
 };
 


