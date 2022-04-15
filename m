Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB7C4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 00:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347900AbiDOAGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 20:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347913AbiDOAGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:06:19 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D75FB899C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:03:53 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r8so7089937oib.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ro+gSfD7MjZ+mLIINFFkXoXNc/h+CjL8cuFVRh2byk8=;
        b=BFR5pAl2lEtAbigA2lyeUxNxd+VrlRZvDrD2+dCzsqu5BGthaWCGx8PGgAo5jQ6/n2
         36LLdQIOTS7fChlUT2/JWuBigQvtLEYAz+JK2UqhP5ueSlb8BEgRZV9Acw8mNXj/Mtff
         T49YhL2p8YcBr5smvMyAh0G2YCcgxAIW752eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ro+gSfD7MjZ+mLIINFFkXoXNc/h+CjL8cuFVRh2byk8=;
        b=30f+qAQd9jTzVGQsUZgQHsTjDzxTL7i7kU3yjChwRe8x8jcONPRdvZgV/rBcdU/w7W
         tLc/C/Twg+L6m5J3B3zdgCfHFw2KVe4hbVFt0xDvqNpy6cmQ+y0x53CS7CNMHiRDYGHv
         0sIrAblP/MsWoCNRETDjNll2jQYUETAM7KYW8JQtmkSFI9jvV1mFVx78mU+/OJDRchf9
         fiyuAe7UUj8HrQ+8yWXnHMZPw5Y6wr5t28TvNCeelxtmW6DpS9Yd0LbYt0SpbNS7jQHQ
         ZhoB7Bl7uKbEjryHrYjomN5JE9LYKvRF9CMh95Nouh8i8xapefBsmaFP8FdJfirc4DBm
         QE6w==
X-Gm-Message-State: AOAM531WwUDhm+7i5znd61JEzvRVjuZZUPiATpswBOq5tF1tPp9I/Huj
        MmceGBdggI7jVymgYCxwcjp6aM6wXGuLs4oRdiJ2Kw==
X-Google-Smtp-Source: ABdhPJyvlqfJpLh6LqpUZLTRAdRrRZ5O4NePRzZQuh/RNO0gZkwkRyFNFYkE75jZPHHTY70a+zi3S+y/ofsIwFxwS/c=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr504998oif.63.1649981032577; Thu, 14 Apr
 2022 17:03:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Apr 2022 17:03:52 -0700
MIME-Version: 1.0
In-Reply-To: <1649944827-6455-3-git-send-email-quic_srivasam@quicinc.com>
References: <1649944827-6455-1-git-send-email-quic_srivasam@quicinc.com> <1649944827-6455-3-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 14 Apr 2022 17:03:52 -0700
Message-ID: <CAE-0n51bQxX8pDeT-nArmt3x1Yv=2T6B8RrapfB4EgHtmdLT_Q@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-04-14 07:00:27)
> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> based platforms.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
