Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7122C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 08:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiGEIVi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiGEIVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317E13DD1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 519706156B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271FEC341C7;
        Tue,  5 Jul 2022 08:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657009286;
        bh=TfRN1QJ6eN15QY/pRMm2YdI/F3oQ61wWL9Xu7uI+LMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPZDn98+RvjsIkoPBULv9O5Ae069Abv7vP+1hzqGOczE7T5u6FHgxFe47NQyY1pLL
         VzTCFpLo1My/zDtSQg+gnj9rQghdh7myY84pTBiBkFr2IAgIn2jsrsq/bXqWFjiDg8
         JV1Z+rUM3Dbk2a3wqEqWg2xln6cgP2bafTulnSFTBD/zrr70k2uhjUfaZ08jUiEdp+
         pN5ika+Y5KzJL61+LKRXXWnKpGlsTCS7ZAwBli7wZ9KWzcNBRIPC5ufoGS/9YYwlYC
         phIHakW82zSPfCZGt+nCAGcg1kXqeYTPUIi7dm9If7hidQ8VwFp97zWwj+Y0+hj1kS
         fh4PMmi/eCLZA==
Date:   Tue, 5 Jul 2022 13:51:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] phy: amlogic: Add support for the G12A Analog
 MIPI D-PHY
Message-ID: <YsP0guiyOeP4jTGE@matsya>
References: <20220705075650.3165348-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705075650.3165348-1-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-22, 09:56, Neil Armstrong wrote:
> The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
> panels, this adds the bindings.
>     
> This Analog D-PHY works with a separate Digital MIPI D-PHY.
> 
> This serie adds the Bindings and the PHY driver.

Applied, thanks

-- 
~Vinod
