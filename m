Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6C3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 03:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242600AbiEEEAk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 00:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243113AbiEEEAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:00:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F751E46;
        Wed,  4 May 2022 20:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAE65B82B78;
        Thu,  5 May 2022 03:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B167C385AC;
        Thu,  5 May 2022 03:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651722995;
        bh=ZGeB6BLdwvK1oB8GeNocJiTdymX72fI2+efXlTwVJ2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4jBnCEOMG45vtff/c4Q77SABn3uxxarmvMAmKk/KmGl27LKQ6zGH4IlcUs3/vXST
         EhH9KV2XJ0o9SKLqPAGo8LZ15aURTkoGY3PbWZa1og9dfbYUaGkczS4dmca7C6cs2x
         7itB+N3joa3qnq0QOGLvwhoxx4OUXMBPfo1pWg/w5r0QvIjdA2jOV5vzUGF3Ekyy3t
         7e4H04Ul+QVepFt4rFfHKJYINkVAsueBUR/XV6uloCYn/h8HgRxRksyZm0YeYuuO2h
         JSvE9A/N+MDo0cFUyrlbozxtyzi7J9Q4sBAv5DwxnCnbIZDFFbfEh/KbL+oAuiVHIB
         pQN1PXyW7FxRg==
Date:   Thu, 5 May 2022 11:56:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] arm64: dts: freescale: reduce the
 interrup-map-mask
Message-ID: <20220505035627.GU14615@dragon>
References: <20220427075338.1156449-1-michael@walle.cc>
 <20220427075338.1156449-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427075338.1156449-3-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:53:36AM +0200, Michael Walle wrote:
> Reduce the interrupt-map-mask of the external interrupt controller to
> 0xf to align with the devicetree schema.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
