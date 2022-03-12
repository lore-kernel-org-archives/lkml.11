Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD613C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 02:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiCLCzB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 21:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLCy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:54:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EF324F788;
        Fri, 11 Mar 2022 18:53:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DE33B80EBB;
        Sat, 12 Mar 2022 02:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7207C340E9;
        Sat, 12 Mar 2022 02:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647053631;
        bh=j4DQ0Z4F7/1qdMCCjWIhTypbozMGPnG0zK+BtArEHoQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SR7gRWzScDnZdEdJWI64VUQoCr+8bsKB8DAQFbDVTrwceEiWB31cJieOyQ0K+I1zM
         ylcIs0UknxCCOAOBVqMnHuph0mGrqblHenc4h0taHAniH61AshrbrmgEwCrhxC3PdQ
         S5IxSBhjq69nF8uRFrMDL4L5iZucvIfofeDFLjSELgzhpdfJ7ic8Bt3NEyWs59EMFZ
         hKfAYdZ8n7ALVW3JQ6mhRtm9ub3Ru+/TPWM75MDfy1fk3uvgmFYHyLnsiQgi7SN2d6
         w1apSzPPFGqdAO6MynlmD1SALIVdUXn1x8o02+VsZMNOasSB1kVMADcq/2wloO3mBS
         A0AxAl8t1vLtg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220225133137.813919-9-gabriel.fernandez@foss.st.com>
References: <20220225133137.813919-1-gabriel.fernandez@foss.st.com> <20220225133137.813919-9-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v2 08/13] clk: stm32mp13: add all STM32MP13 peripheral clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Mar 2022 18:53:48 -0800
User-Agent: alot/0.10
Message-Id: <20220312025351.C7207C340E9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2022-02-25 05:31:32)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> All peripheral clocks are mainly base on stm32_gate ckocks.

s/ckocks/clocks/
