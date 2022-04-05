Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750BCC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 15:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389009AbiDEPVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346982AbiDEJps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947ADCA84;
        Tue,  5 Apr 2022 02:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E39A616D9;
        Tue,  5 Apr 2022 09:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71231C385A6;
        Tue,  5 Apr 2022 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151131;
        bh=Go6Z5f/W2tjhRUO6APCSVvZp9thB6QaQP0llR9z2jKo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=hdsFI/q/QvQQgJTabRoqDsscN7FDlRBQbb5rEDsIwQT389IMRr5Vcrq7MnX0zCSXo
         e4TwiVVhB/Qg/SmKJrpCxDg6oVJxnW16Zn2dCtAJQkl3/wpo2FafjYygnY+r4IYZZp
         w7G7/274oFfHviHe4Kfv9/xUkx6MRAmwf6ouhLkiLloFXnWd2IvR3+CuIeowXI4E3X
         cW3A4G/W23mqabqTYz/vKQNE1zuwUyyLlMlODDC/gXwdRheg1XHP9P08pwFT8bTFEM
         xTeAP11kXG8PMs4ArP84n8ak/5vx/AG+opRv7nV/ra+MVD5Z5PzfOslAtnyFoC4xes
         5yX+LBhnFaKFQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        krzysztof.kozlowski@linaro.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org
In-Reply-To: <20220401153711.1057853-1-krzysztof.kozlowski@linaro.org>
References: <20220401153711.1057853-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] regulator: dt-bindings: richtek,rt4801: minor comments adjustments
Message-Id: <164915113019.276837.6765844554684988945.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 17:37:11 +0200, Krzysztof Kozlowski wrote:
> Correct grammar in 'enable-gpios' description and remove useless comment
> about regulator nodes, because these are obvious from patternProperties.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: richtek,rt4801: minor comments adjustments
      commit: 41812783057c01e4e5f1eec649607e4773124dba

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
