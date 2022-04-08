Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE8EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 11:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiDHLif (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 07:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiDHLib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C71245B0;
        Fri,  8 Apr 2022 04:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14F0C61BA6;
        Fri,  8 Apr 2022 11:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7287C385A5;
        Fri,  8 Apr 2022 11:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649417787;
        bh=7JpZeNNMmwO8njRHTYclVOTycq3oNZ6zf3BkO+SYLz4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=njafRzCTGjVpgGIKEKKoFCTfZZ7uGG1HIS3RK7gByZY44COCMTBlvQp7DwKm8oBqi
         cHNU9RsHry/FrZOSdHWAKvDwPSDG+F2tJMKS+l8MaNehk9O3fnM7go+/gYED7Xa36+
         rdshYI9XONI7DYpctMA77AM6gz4OInxa8FwNLLJwDHX01DhBI0chMc1G65U8YabETp
         JdfXH1bjgaXYi/P6aR/Vq+zIE5RInD94CEyZwf9PNt575zxNzEOZBshsKzXq/XT0jx
         7ktXPfdS5oaTPchqGYUSSrk3MlrV9nWb4+9vONCTcwzudJ5FHu1Y0/lrWkt5Ea7qaK
         8r1CDD4sdAnyA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        hayashi.kunihiko@socionext.com
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <1649145303-30221-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1649145303-30221-1-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 0/2] dt-bindings: regulator: Fix uniphier descriptions
Message-Id: <164941778560.1391998.5290643188826577501.b4-ty@kernel.org>
Date:   Fri, 08 Apr 2022 12:36:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 16:55:01 +0900, Kunihiko Hayashi wrote:
> This series fixes dt-schema descriptions for regulators implemented in
> UniPhier SoCs.
> 
> Kunihiko Hayashi (2):
>   dt-bindings: regulator: uniphier: Clean up clocks, resets, and their
>     names using compatible string
>   dt-bindings: regulator: uniphier: Use unevaluatedProperties
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: uniphier: Clean up clocks, resets, and their names using compatible string
      commit: 2eacc8479c1f6610288f619a23c374502176ca66
[2/2] dt-bindings: regulator: uniphier: Use unevaluatedProperties
      commit: 65adf7234a0dd68217f58715b0b5fd940b630529

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
