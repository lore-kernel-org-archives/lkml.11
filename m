Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F8C3F6B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 12:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbiHYMbr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 08:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbiHYMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:31:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE632B2CED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:31:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s11so25865799edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GpfgEoOH4Bk0o03BXzXfbjZSZHr+iWqvwXSXT6fbHDg=;
        b=aJDALMPobe0TjSh/jiJJfZku827C0K6keCQCIpXty6OvQ/1gDP0KEl3Zh1+tQCiUPN
         FZuZW5tsnab7jNTnlMJ4YZySqHgaNfqs5mwtbjlnIYr9M6+whBK7uftBtVEyvJnSBQ7z
         fuiyYX/H2NKWhlvR66MZOsHc3JZMgKzOBB3LkFy5M8Vo2t5aBv+i7++c3/g2BD2oq9o+
         vRPLQAMw89+BYM2XOvmulF/NB22gpgQeTopMu9SrsN31yNX0hZOccyckJT1Dzib+QcCC
         D2MzvJFyilBzpmtyGSDIDTWatSUSlyXjDtUXJA+JJVFR6ESHfTeqjTt9NDe1cD71Mgnn
         4pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GpfgEoOH4Bk0o03BXzXfbjZSZHr+iWqvwXSXT6fbHDg=;
        b=n6Y4AHAWbNK/5S2MHI6L91F5BC97euVVklIs+VGSLuHjB/mWWISUlOrS4K50tCpBmP
         zZoLW/VILbBMir3F1YoQNuKYMoNHVQdOG3N0m8tnjHuV6AjDmUubAnk/lKXDo7diLhyj
         ssbQdJVKVnAj6slFMIKxG6mw2J3kxVDSH0Sp4k5h+aOQwiZRwjSdTv4E+pW8rP7Noz5d
         gbKmPkDJmn716OZar6Q4bjqxRkGYAQPBGR5LSHKY2DqzW8Gpw+OtaNLAzIR5ADwrPEew
         M++VMBzOvZYMH2ZAiXXSbxUI7AhdvEqPUBuOgHUMQCmaWlFK1aDi6Dw/cjm8CvGl8gZX
         AtTA==
X-Gm-Message-State: ACgBeo39G2vMNl+wQEcHYuEFkeShAZ4zRsSXcmOjVpxJjnHlWpJHw45Q
        CIOF/BOfwke7wRq+ruNJme+ynG/lOlPd29T8v36Qvg==
X-Google-Smtp-Source: AA6agR5AzWiEJVw97Qs0InhBJT1xWHu/mHYs4QXnlx7YgLLGzvNmzJPWmXmaE8ZpDzHKOuoj/4+kW5Z5Q4A2grdcxVM=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr3051832edb.133.1661430684201; Thu, 25
 Aug 2022 05:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220817113833.9625-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20220817113833.9625-1-srinivas.kandagatla@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 14:31:13 +0200
Message-ID: <CACRpkdaMyqtY+cQZSmcs6Hejoin7DKTVWbxTvfkSSM7ceo72NQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pinctrl: add support for SM8450 LPASS LPI pinctrl
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 1:38 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> This patchset adds pinctrl driver to support pin configuration for LPASS
> (Low Power Audio SubSystem) LPI (Low Power Island) pinctrl on SM8450.
>
> This IP is an additional pin control block for Audio Pins on top the
> existing SoC Top level pin-controller.
>
> Tested this on SM8450 MTP
>
> Thanks,
> Srini
>
> Changes since v2:
>         - removed unnecessary quotes in bindings
>         - remove lable in bindings
>         - fixed gpio pattern and remove an extra line

Patch applied, the patch looks innocent and bindings are reviewed.
If Bjorn has any further remarks I can always pull it out (or you can make
patches on top).

Yours,
Linus Walleij
