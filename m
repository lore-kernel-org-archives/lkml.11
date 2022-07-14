Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C516BCCA482
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 18:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbiGNSvd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiGNSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C466AC0;
        Thu, 14 Jul 2022 11:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE83621CC;
        Thu, 14 Jul 2022 18:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16FDC3411C;
        Thu, 14 Jul 2022 18:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657824664;
        bh=rN074FtrJ8R9G6o+chaH544/17JWvBJOlSaAc7tJsLk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q8FyqhWZitWwxrB9QerGJMezpMKADzG0PS11dw8/CD3GySV4rL2T0AysJ7ufOI1V9
         SaXOHo/+XcJgwqavB2/IHm8H4cdQP6W4Y2KIm+qpnHdihm492cRRsy8VG3jNJyobFe
         2za00y6sXlrD3h99MkBKlVj/ukK7EHjz18iZiQ8TxMLlMrsXGSHEnCWrBpRxUacAXt
         dHiXe2SOd0n6ny9ZqB0dwJFrgB9MqKPgL18rVUa41UrDOl+DkxUzVG43RWn26f5f72
         vTXs+569C0//nENp6A13/SEkd0dpPni0XZy3IoBo6zAadEAGPtfmW8YescGDHGmOwQ
         OL5xYrIEqD8IA==
Received: by mail-vs1-f50.google.com with SMTP id t127so2302055vsb.8;
        Thu, 14 Jul 2022 11:51:04 -0700 (PDT)
X-Gm-Message-State: AJIora+3r9CWFBOMCwZXEshAMRRw7IV8JPqKAw44yV+wsdMSgHBaM+T/
        rNB9c/WC3Su4O7CxO+wWZbA0r4NLmMj+9lxdSg==
X-Google-Smtp-Source: AGRyM1vUsSaoKpbdafru34s5RwN0ZR6mPRZFDN0cvIm/7IlQDf7RUjZdUbmtoHe+Qifs3lUXJunq6h01WhDwNiTPp5Y=
X-Received: by 2002:a67:d194:0:b0:357:8ea:5554 with SMTP id
 w20-20020a67d194000000b0035708ea5554mr4227834vsi.0.1657824663603; Thu, 14 Jul
 2022 11:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220626191630.176835-1-david@ixit.cz>
In-Reply-To: <20220626191630.176835-1-david@ixit.cz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Jul 2022 12:50:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJi_Nx90BoJsZoht-HCdUoEG_Hsg+FjPKu=xa1-PZOAmg@mail.gmail.com>
Message-ID: <CAL_JsqJi_Nx90BoJsZoht-HCdUoEG_Hsg+FjPKu=xa1-PZOAmg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, ~okias/devicetree@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 1:16 PM David Heidelberg <david@ixit.cz> wrote:
>
> Convert Qualcomm SPMI PMIC binding to yaml format.
>
> Additional changes:
>  - filled many missing compatibles
>
> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v3:
>  - added subnodes, there are two not converted to YAML yet, but it works
>  - now it prints milion directly unrelated warning to this binding
>    (it's related to the included subnodes bindings, can be merged,
>     but it'll generate more warnings and preferably anyone can takeover
>     from here)
>  - add qcom,pmx65
>
> v2:
>  - changed author to myself, kept Caleb as co-author
>  - moved nodename to properties
>  - add nodenames for pm* with deprecated property
>  - add ^$ to pattern properties
>  - dropped interrupt-names property
>  - added reg prop. to the nodes which have register in nodename
>  - added compatible pmx55
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
>  .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
>  2 files changed, 191 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml

Looks like the referenced file is in linux-next, so:

Reviewed-by: Rob Herring <robh@kernel.org>

This should fix a lot of undocumented compatible warnings.

Rob
