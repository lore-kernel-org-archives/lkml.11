Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A794C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiBVUkw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 15:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiBVUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:40:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063C41F96;
        Tue, 22 Feb 2022 12:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92B22B81C68;
        Tue, 22 Feb 2022 20:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEEAC340E8;
        Tue, 22 Feb 2022 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645562419;
        bh=VFMb5ZaArHLdNOowG1IEvI6qPtYj742MYvkI52WdAKY=;
        h=From:To:Cc:Subject:Date:From;
        b=GEMGqFDEhUkiZ7yCz0EHRMCbxJUMjVQYBvq7tMIeTsVnwChu9AkL/6cuiAVtWgy/A
         j2GGPnxZXspKgDOg6difyM3j0rb/Cz4KYpoNRqNvyf+tgffmGkB/VNmJpPr+VUfEND
         nzX8WRSf8cw7sfKEy/qMaZaXUsjRE+MEtCObg6ekebgH2Y0+l8wvL0hvsH0HfykgA7
         /LaJagYrbRIgoSZcPN5Cazb1GjMIaJf2+JKOjGy3i0Jc11b2hQGaEdrcPnVrp2XiCa
         EqyJojlGsvPa5AQc5fLsGdx7e7/mthu/Fj0l+VNUP8Ud1T6FPlSIX1pJrVQ2t4REQw
         kwZbIYEqqwy4g==
From:   broonie@kernel.org
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Nyekjaer <sean@geanix.com>
Subject: linux-next: manual merge of the iio tree with the char-misc.current tree
Date:   Tue, 22 Feb 2022 20:40:14 +0000
Message-Id: <20220222204014.3547123-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the iio tree got a conflict in:

  drivers/iio/accel/fxls8962af-core.c

between commit:

  ccbed9d8d2a53 ("iio: accel: fxls8962af: add padding to regmap for SPI")

from the char-misc.current tree and commit:

  fbbd286c16a6c ("iio:accel:fxl8962af: Move exports into IIO_FXL8962AF namespace")

from the iio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/iio/accel/fxls8962af-core.c
index f7fd9e046588b,8e763dbf096b5..0000000000000
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@@ -178,15 -178,7 +178,15 @@@ const struct regmap_config fxls8962af_i
  	.val_bits = 8,
  	.max_register = FXLS8962AF_MAX_REG,
  };
- EXPORT_SYMBOL_GPL(fxls8962af_i2c_regmap_conf);
 -EXPORT_SYMBOL_NS_GPL(fxls8962af_regmap_conf, IIO_FXLS8962AF);
++EXPORT_SYMBOL_NS_GPL(fxls8962af_i2c_regmap_conf, IIO_FXLS8962AF);
 +
 +const struct regmap_config fxls8962af_spi_regmap_conf = {
 +	.reg_bits = 8,
 +	.pad_bits = 8,
 +	.val_bits = 8,
 +	.max_register = FXLS8962AF_MAX_REG,
 +};
- EXPORT_SYMBOL_GPL(fxls8962af_spi_regmap_conf);
++EXPORT_SYMBOL_NS_GPL(fxls8962af_spi_regmap_conf, IIO_FXLS8962AF);
  
  enum {
  	fxls8962af_idx_x,
