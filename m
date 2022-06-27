Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40824C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 07:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiF0Hrn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 03:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiF0Hrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:47:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED86144;
        Mon, 27 Jun 2022 00:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F0A0B80FA8;
        Mon, 27 Jun 2022 07:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B245BC3411D;
        Mon, 27 Jun 2022 07:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656316058;
        bh=ExS/BCJHC4+PJVL1dRp22s463RCYLIK+e85ErG13A20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRuKd48OtEgh8sv7wxAiFiBnYpq70a+wKULZMmrllJN4X6Yhmn8fOZeB/i2DYdmdB
         helSkGTfQYx2g+e6j/dHvju9qqFLWkgyF+gGhS02Nl005kYXm6waeyrzdrMqKS5cpd
         xZlrCPMSnA0nn6GNjDvhx5OJYYbXCn7lAoPCj+trzmfcU8TyPvVfM3HWGB9nZjWnmQ
         qlTsJMS3h2kuoQ21SgyJVdOjh6BQ579nKIEEMdijMZnuVP1sCTSuTXjZEkQYOk3kdg
         0BsiWavUs1DTZABjjmamypRUSn1SX30Dhm71pKtCRzcExFQozzoyLhIb2eJutTDoWk
         WvRk0i+6w6Rxg==
Date:   Mon, 27 Jun 2022 15:47:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin van der Gracht <robin@protonic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH] ARM: dts: imx6qdl-prti6q.dtsi: Add applicable properties
 to usdhc3
Message-ID: <20220627074732.GF819983@dragon>
References: <20220621140334.568446-1-robin@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621140334.568446-1-robin@protonic.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 04:03:34PM +0200, Robin van der Gracht wrote:
> The usdhc3 interface is connected to a soldered eMMC chip on all boards
> that import this dtsi. Adding these properties speeds up the device probe
> during boot.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>

Applied, thanks!
