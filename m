Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4436C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 06:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbiCXGSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbiCXGR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:17:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0069681A;
        Wed, 23 Mar 2022 23:16:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F2DA68B05; Thu, 24 Mar 2022 07:16:21 +0100 (CET)
Date:   Thu, 24 Mar 2022 07:16:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220324061620.GA12330@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220321165049.35985-7-sven@svenpeter.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +//#define DEBUG

This should not leak into the driverṡ

> +#include <linux/blk-integrity.h>

As far as I can tell this driver does not support metadata or PI,
so why is this include needed?

> +/* NVM Express NVM Command Set Specification, Revision 1.0a, Figure 18 */
> +#define NVME_OPCODE_DATA_XFER_HOST_TO_CTRL BIT(0)
> +#define NVME_OPCODE_DATA_XFER_CTRL_TO_HOST BIT(1)

Please just use the nvme_is_write helper where you are using these.

> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,

Please avoid > 80 character lines.

> +static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
> +{
> +}

So where are the apple specific resources free?  ->free_ctrl is
the callback from the struct device release callback, so without
one the resource release can't be tried to the device release.
