Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A957AC4332F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbiDGLfM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 07:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiDGLfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5448411DD19;
        Thu,  7 Apr 2022 04:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E000561E7E;
        Thu,  7 Apr 2022 11:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C04C385A4;
        Thu,  7 Apr 2022 11:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649331189;
        bh=afAHMXI/+97xz/pqhFgQCdEbLqnWZ0KuOYIPwHdj95s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jo49GSPW39lIpVk8HI4EkVqBia1qwzJ+ivXJwW9y/1zviHZuNTVtdNZ/AvxjeDvZV
         QlaAptWYuLKtGMxIx8c77oG/C5ldgBUP6ldr6kYfjbSpM2I0zpwFNX/WIpda7P4g43
         wHrS3wy0g2VFqArV7z0tjXWE8Xpps4nYJWcZpgqbDnyWKav7zb8bMZu8Vj3qQ28x7r
         xWNGd8HkNQvWTcVU0XwTRXu26JwKbgH6kBhu34tG6LpQIEpd7A5wbQSE5T3tqpnZ1c
         +FuN4GsgsJEYKBAiNYt4ShhaQOnSZtrsx81gwWQCdZ1yklEl7otD4qVD9fKOUis6Yz
         jXjLJWSJ7MI5A==
Received: by mail-pf1-f169.google.com with SMTP id b15so5182238pfm.5;
        Thu, 07 Apr 2022 04:33:09 -0700 (PDT)
X-Gm-Message-State: AOAM530+huPvy5YcGdFwsGPMLFXYL6+XTP2XfjXwqVHMLZTaeZbhdu0f
        faSWwXVRKesNKk491YrOMVHsaCAC+Y3yZqwWSY8=
X-Google-Smtp-Source: ABdhPJzmpH6LsNZA/AxxNXzRC5tAwZhDCYBjDPMbk6i2A4Wh2dNjxJQO1spVY+LTOIoRI6FSSdQtm7clTckDNI4oI2c=
X-Received: by 2002:a05:6a00:1501:b0:4fb:2d19:b6a8 with SMTP id
 q1-20020a056a00150100b004fb2d19b6a8mr13844107pfu.21.1649331188732; Thu, 07
 Apr 2022 04:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220407075427.41141-1-chenxiangrui@huaqin.corp-partner.google.com>
In-Reply-To: <20220407075427.41141-1-chenxiangrui@huaqin.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 7 Apr 2022 13:32:57 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf38LTFzjP0mDEu0wo3AmTPLgU_jv7t+TXxJTuVtoVkVw@mail.gmail.com>
Message-ID: <CAJKOXPf38LTFzjP0mDEu0wo3AmTPLgU_jv7t+TXxJTuVtoVkVw@mail.gmail.com>
Subject: Re: [PATCH] [v2]arm64: dts: qcom: Add sc7180-gelarshie
To:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 at 09:54, Mars Chen
<chenxiangrui@huaqin.corp-partner.google.com> wrote:
>
> Add device tree for Gelarshie, a trogdor variant
>
> Signed-off-by: Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>

Your subject is incorrect. Please use `git format-patch -v2`. You
still did not provide a changelog (put under ---) against v1. You
still did not reply to my comments and did not implement them.
https://lore.kernel.org/linux-devicetree/a0eb6bf9-256a-29b1-2211-496df710f531@linaro.org/

If they are unclear, please respond to them, so I can clarify. However
you did not respond but resent without implementing them, so it looks
like you ignore the comments.

This is not a good process. :(

Please read again:
https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/process/submitting-patches.rst#L307

I am sorry, but I have to NAK the patch till you respond to my comments.

Best regards,
Krzysztof
