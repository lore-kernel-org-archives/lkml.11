Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C2ECAAD4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 22:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiH2WIC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 18:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiH2WIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6825FA2DAA;
        Mon, 29 Aug 2022 15:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E16AE612C4;
        Mon, 29 Aug 2022 22:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDDCC433C1;
        Mon, 29 Aug 2022 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661810878;
        bh=bpIwel92UszcooHpKnW5jheKzDmf92uU2P4lV570Oik=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E0xSApUGLhLtJbqh/YgZbxChqVcjFUVLO2kjPoo3EtNA7SCpEipRXfWxc3v/OcY2z
         QLQsAyOJNZPb5qrrDmmyALVMGfKehjJVkFJMj76Jp2bQldwxHbwV1uiZxtXkAlYfnU
         4cpsqLqoSVNIeOHoUwfLDPvE/cZkDJfbfPgiNyfIZuJLQknjajJ1esBoM/csIhFNIM
         +shE8Eo721oyevDXc3YIkpCSSKd9hii+ks88uEqKCMA7iSIjtmPAKgXsSultINtqpg
         JCKgRIuBHCg8tltAR4KY32S8dgYg61mrPHoSVeQViYO1+mbO8WW/HFRvE8bhUZXMUW
         VIsWLcc9qhIqg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 00/14] arm64/dt-bindings: mfd: qcom: SPMI PMIC fixes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Aug 2022 15:07:56 -0700
User-Agent: alot/0.10
Message-Id: <20220829220758.2FDDCC433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-08-28 01:43:27)
> Hi,
>=20
> The Qualcomm SPMI PMIC DT schema conversion was not really tested and sev=
eral
> issues in the bindings and DTS should be corrected.
>=20
> 1. The DTS patches can go independently.
> 2. The binding change continuous work of PWM reg fix and depends on it in
>    context (diff hunk):
>    https://lore.kernel.org/all/20220827145640.3530878-1-bryan.odonoghue@l=
inaro.org/
>    Binidings changes and above, can be taken via MFD tree (fixed commit w=
as
>    merged in v6.0-rc1).
>=20

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
