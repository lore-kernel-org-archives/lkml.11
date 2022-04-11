Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB958C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 01:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiDKBy1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 21:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbiDKBwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E302BC8;
        Sun, 10 Apr 2022 18:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ECFA60FD2;
        Mon, 11 Apr 2022 01:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FA9C385A1;
        Mon, 11 Apr 2022 01:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649641826;
        bh=scU/wt9Y7hTgr9P069KO0dFurEObKBwZx5KXA8rxJGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHElk7Wf5pPUAZI0hAcgnkgBApY3HQZNLwHmI4PXeix6YDvD/GZWUl2WIh0lO2Xol
         rKN3fMT9151oDT8VD0EY0u3IUi1SxPEFheRHcYzlaIoHNilC6gbgenYPv89/YqolM9
         vVUtZ4Xj552A16gGsiLfpCxNLk1Lk8Sc8QvAzawKQv2+sqWCcVp9FEoiiJmSM9IaH4
         /6yKfM2tOiWU5iw3oqrHDRqqXy+iRiBQ5ToDJtr+sUvfdAd6kV5pS2rBqSOoUp2R+B
         UlbN64YXhwPQ22YpLMX+VHfIhianJJpHg/P0AHAGeH56h1zuBav9pEDL0bYCO5rWS7
         Jvokf2Cuo2tUg==
Date:   Mon, 11 Apr 2022 09:50:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx: align SPI NOR node name with dtschema
Message-ID: <20220411015018.GE129381@dragon>
References: <20220407143155.295187-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407143155.295187-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:31:54PM +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
