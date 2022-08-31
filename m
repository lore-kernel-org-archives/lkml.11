Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85403ECAAD3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 06:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiHaGry (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiHaGrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B222A414;
        Tue, 30 Aug 2022 23:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBBE617B7;
        Wed, 31 Aug 2022 06:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57E5C433C1;
        Wed, 31 Aug 2022 06:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661928469;
        bh=HZIF+ZpDbGsuUfg0vvXTrqAXedY4CM7K9UO0N25BY0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NOfhrR8PP9pKn5SL/u5aF4CK8VJX+734bfqaYFkg1XnZYnhuQ/M20BciLdqNVLFKq
         jp6uCkk/yYS5HlvZgepLtO7S0Y685wB78jPVjQRWCX1hO3YO0DaZ9qBh1mFwBIJ5Lm
         FO8+HJCViDLpyr3fzAdigfHjLG1iuEywlGvumfdLONhw7bRJC27CIZe3yNu49hUfIo
         EBcP5aTuuQW9xoubzcCHeclYyjDX/0mHN/iKEszCH3+7fG7xWUsZjNbgxggX2QFajN
         Ej3Jm0aFOndZlVgsUYl75eqLAZP5a+iQp0zWkCemwsHE9wsPCOlj2LmrGJa0cNy0Bd
         Yy4Ar7B4Pqddg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oTHVr-0006GG-98; Wed, 31 Aug 2022 08:47:47 +0200
Date:   Wed, 31 Aug 2022 08:47:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64: dts: qcom: Fix broken regulator spec on
 RPMH boards
Message-ID: <Yw8EE/ESDUnIRf8P@hovoldconsulting.com>
References: <20220829164952.2672848-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829164952.2672848-1-dianders@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 09:49:46AM -0700, Douglas Anderson wrote:
> Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") several boards were able to
> change their regulator mode even though they had nothing listed in
> "regulator-allowed-modes". After that commit (and fixes [1]) we'll be
> stuck at the initial mode. Discussion of this (again, see [1]) has
> resulted in the decision that the old dts files were wrong and should
> be fixed to fully restore old functionality.
> 
> This series attempts to fix everyone. I've kept each board in a
> separate patch to make stable / backports work easier.

Should you also update the bindings so that this can be caught during
devicetree validation? That is, to always require
"regulator-allowed-modes" when "regulator-allow-set-load" is specified.

Perhaps at least for RPMh as it seemed you found some cases were this
wasn't currently needed (even if that sounded like an Linux-specific
implementation detail).

Johan
