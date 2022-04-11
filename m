Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D5C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 08:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbiDKI7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiDKI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:59:22 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AFA1FCC3;
        Mon, 11 Apr 2022 01:57:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 617041C000E;
        Mon, 11 Apr 2022 08:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649667426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N94CYxFySJWV4VTz8jcRQZhwRVn/OQKhsKV51XZEAU0=;
        b=RIsgV0HihF5l10iOAlUFxswjPna2xqnCkS24ImR02PY/9BRka7FVhGpbBMDlFA+1LKaulc
        kMF8P28DziXYcpQaO75+wm2W9c0vh9PBgZNtPLRLhRD+gDtwDcb9zgb5+gDUoSyKTUfZ2k
        be7QSdpggLiRjMJ8maI24tfVemarUPC2iOVOzrRQSMJO8lQyJ4c6qW7vqMMQycaIt1hgZL
        OltUOzfq7dVkGCX7q6NzEWkQ3s45rvweyMKDJ/b9EfIqnaW+ZabgL8GDRULRhwvxehm0zk
        Oai8JOE2ZRjQmXzzN+0i7CSntfwEVoZC0fOg4nn78Cz3nrVixp5cdURGuLBUow==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mtd: jedec, spi-nor: remove unneeded properties
Date:   Mon, 11 Apr 2022 10:57:03 +0200
Message-Id: <20220411085703.10796-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220408063720.12826-1-krzysztof.kozlowski@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'36f83e2754f9d2d96182a5570a16f057ab5932e0'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-08 at 06:37:20 UTC, Krzysztof Kozlowski wrote:
> After conversion the jedec,spi-nor DT schema to reference other schemas
> (SPI and MTD) and use unevaluatedProperties, few properties are
> redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
