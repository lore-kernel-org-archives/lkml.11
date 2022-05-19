Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAE0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 00:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiESAok (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 20:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiESAoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEB760AB1;
        Wed, 18 May 2022 17:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0804A61760;
        Thu, 19 May 2022 00:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634DEC385A5;
        Thu, 19 May 2022 00:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652921077;
        bh=MKtFYBiTymoYBzIoCiaTc+DKg1Jpthbmtursi+ecuO4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WVUZpx/aLqjyt8aC5ct2cA+7R7Z6H3hzT8m5f/Oh7tXEmJlXtN1Lsi9Tisn4gNqTB
         F6pun+/tYhkYJXHQ+vJeqKB7fpXPSsB1Cmm28tnktXRg5zu9OVNkA6wLG5kgTA65la
         hDMJGf59qAMJKeb+SwyKNuuWaTd3WHNvV7F6pFuZwgdh2Wv4TLnZmluwLIq9abjcRP
         thZH9k3xmgxpgyikz/4dvuP+qIEhSGIPOTOzcvun/OYtsHgAFlqgDiykUcxkEPl9di
         ARmP+9bub1zueDaaqbpnTLS4cO2s4jhUwKIraFuyhQ+z4kGXJPWWhpuzmWqILSIHb7
         AEEgxWCjnrvyQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220505025457.1693716-3-bjorn.andersson@linaro.org>
References: <20220505025457.1693716-1-bjorn.andersson@linaro.org> <20220505025457.1693716-3-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 2/2] clk: qcom: add sc8280xp GCC driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 May 2022 17:44:35 -0700
User-Agent: alot/0.10
Message-Id: <20220519004437.634DEC385A5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-05-04 19:54:57)
> Add support for the Global Clock Controller found in the Qualcomm
> SC8280XP platform.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
