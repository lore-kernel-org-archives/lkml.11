Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD1DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 03:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351761AbiEUDwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 23:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiEUDwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:52:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DDB5C853;
        Fri, 20 May 2022 20:52:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60589B82E0E;
        Sat, 21 May 2022 03:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD9AC385A9;
        Sat, 21 May 2022 03:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653105148;
        bh=IJFPrEy8FPKljy7dggxaDoQSTSF/XCWVm/MCYmWCcfA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=U/coIXKJ31ChOzrurF+JcO+Q4+6Cwm5xCBWbJrbmXUxUccXGs8axElsM9s4EFqhGZ
         sjFfIUISCeRV30dJRAx62/Y59WPmy5/0WYnmt/UTRGR9hr1GtgFnUonFXf17f89S3q
         lMJ/xPeFeIah2Hf0VNbwZE5GnARHzUdSy7R54guubey/GiHZK6e/IC9n0vddp3+hvl
         ZWZySjOZoRKARD9rDp0oePaAgvnXgFYLBeV991KreOCQACrC1FUqsMruKFW9DevAxV
         aFN/1t4mZRxJKBskSVXQqjL9EbBCXA0kFfIMvc/unDPaKzZDEQIPU6RJvKh5NMZWbE
         yJrdEhUOQv9GQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220520100948.19622-3-johan+linaro@kernel.org>
References: <20220520100948.19622-1-johan+linaro@kernel.org> <20220520100948.19622-3-johan+linaro@kernel.org>
Subject: Re: [PATCH 2/3] clk: qcom: gdsc: add support for collapse-vote registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Date:   Fri, 20 May 2022 20:52:26 -0700
User-Agent: alot/0.10
Message-Id: <20220521035228.1FD9AC385A9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Hovold (2022-05-20 03:09:47)
> Recent Qualcomm platforms have APCS collapse-vote registers that allow
> for sharing GDSCs with other masters (e.g. LPASS).

Maybe just say 'with other subsystems' because LPASS is an entire
subsystem.

>=20
> Add support for using such vote registers instead of the control
> register when updating the GDSC power state.
>=20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
