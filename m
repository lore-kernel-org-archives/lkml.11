Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3389C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 07:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbiCKHFi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 02:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347160AbiCKHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:05:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F77F3902;
        Thu, 10 Mar 2022 23:04:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 517D2B828A1;
        Fri, 11 Mar 2022 07:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8932CC340E9;
        Fri, 11 Mar 2022 07:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646982258;
        bh=rrHspg7Ylw8zkgvzk8rWXvrSp8M1yZ57i9LljsbOKu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kETAt/E2eJJIjMniehBSzrr9L2gaXT9biptCSI6TOII35wyzAFg5ed59FgYs483Zz
         MgJrsZAZaP44TDImzwLzyOO5LtWf98APvq97wzwonKWyHWlPMH0H9Y93ftFpjxRM2B
         llcW2kooNCm0ZclX4k63eeAgsbAd4ydEBFNHd95FR7Up20j4D7k1Slz4b26uJoviOt
         dQBiQ00PH8ahmFsqtNELPl9vVUXDiqBwP09QsJoBUvEyDefno8RpjFMjEvK7gYWkbL
         xHz/MyeoE1mzl1ZbFag+1sDtkU6ekLVij27gPM8lHj5HxXE6fCSdZotS8UxzUxjZ4+
         VqjHPHSfhRZuw==
Date:   Fri, 11 Mar 2022 12:34:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dmaengine: sh: Kconfig: Add ARCH_R9A07G054 dependency
 for RZ_DMAC config option
Message-ID: <Yir0bvf4QSt9b8Lb@matsya>
References: <20220221224321.11939-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220221224321.11939-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-22, 22:43, Lad Prabhakar wrote:
> RZ/V2L DMA block is identical to one found on RZ/G2L SoC. This patch adds
> ARCH_R9A07G054 dependency for RZ_DMAC config option so that the driver
> can be enabled on RZ/V2L SoC. While at it, also update config help text.

Applied, thanks

-- 
~Vinod
