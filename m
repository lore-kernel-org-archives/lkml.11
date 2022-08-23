Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA5CC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 19:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiHWTn4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiHWTnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:43:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0F78210;
        Tue, 23 Aug 2022 11:44:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gb36so29163302ejc.10;
        Tue, 23 Aug 2022 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mE2uuXhnOCBfGRFD8JVhu3ERDiR2gzRpdMBo3mVwdjk=;
        b=WzE808DGu7i8pZFIArBxO4Tcwgvc3CjL12AdpUErOlEsYrPBsOelwu3Behq3OpNBeH
         QULAAG9N0lmCFQqnoUJO4RMru8zuIMYBc6XNtA9Bdebd0aV5cqG4BN5gaQlsik5WByMr
         ZCJ5W1m7l1/yA3/c608F8ft4kdfdyLUaqGo9qWfSBIbhK6ZnU4aajGTD8xwOzQYAal7t
         5y9tXUwbjzxRelhmWLyp7Qh0L1BH4btVYhV6Bvl/C8WhvE2+2EpZzbAsGuUMwg+SlK7q
         RIsaefSNRqrzXW2Li7rcYQgSXBNJDgLsQEzHbOXDEmgsCNPqfR3S516MHQj4gNWy3HYr
         +1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mE2uuXhnOCBfGRFD8JVhu3ERDiR2gzRpdMBo3mVwdjk=;
        b=sMKz+DeBPybD9qKQY/D3Nd30ETx2Wvc7+H3Wx9IWRcKjLMWaG26M/Q1HMm1gjFbQDD
         DaRTjOiclmCxngH1LLvJZH1HAOzH8IpmcRqCwIZY5pxZ+6w4avH3UBeOxGmIKKO7cnTs
         E5N+GhSl0AnjHkA9+CE6F3EhSzqwvMXAFMI0gNuatnk5AMkT23fsO/tDnAbZAXCd+EpB
         0R3CwNC66gxAp19RPqdRmtewB1gQDQa7QhBidLwKX2CfXfGP/99pxK7SzWh/L2t5ENAI
         L5dxkph36ESBUJlyPfu/W8QfarYjJSErb0/8YsJD/6Fd2wasGFBbog+fBxxn+yPJNlER
         Oqjw==
X-Gm-Message-State: ACgBeo3j+uZFYMfU2F/EDZFzA4wR8U5uzoCdLN8YAHMKQDIkXIM6aWim
        W6Ah8GS9rhHzJ5uiqGXFq7pc2vbs85IDvWc4u1xHVw6r
X-Google-Smtp-Source: AA6agR5UfBMiSR7RVL5LukrusoA9jAvxTmaYlIOyJgm0SSnvHF5qEfG2WcVOWsn9ovD5pd8CXBBQRghwa4nR0pJdGgM=
X-Received: by 2002:a17:906:6a10:b0:73d:939a:ec93 with SMTP id
 qw16-20020a1709066a1000b0073d939aec93mr605014ejc.112.1661280275602; Tue, 23
 Aug 2022 11:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220805125618.733628-1-conor.dooley@microchip.com> <814208de-e3e4-852b-766d-14889a6c3c91@microchip.com>
In-Reply-To: <814208de-e3e4-852b-766d-14889a6c3c91@microchip.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 23 Aug 2022 13:44:24 -0500
Message-ID: <CABb+yY1DtHmknUPTzp6OiZsFL5zgwptSREfwzzX9d3EW46V0Yg@mail.gmail.com>
Subject: Re: [PATCH 0/3] MPFS mailbox fixes
To:     Conor.Dooley@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Daire.McNamara@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 1:42 PM <Conor.Dooley@microchip.com> wrote:
>
> On 05/08/2022 13:56, Conor Dooley wrote:
> > Hey all,
> >
> > I spotted a couple of bugs in my mailbox driver while developing some
> > new features. None of the features these bugs relate to were in use so
> > they've gone unnoticed until now. The binding screwup is unfortunate
> > and I don't really know how I misread the register map so badly.
> >
> > Jassi:
> > Not sure if you prefer developers to add a CC: stable or not to patches
> > so I have left them out, but I would like to see them backported.
>
> Hey Jassi,
> Have you just not had a chance to look at this yet, or are you waiting
> for me to resend with the extra fixes tag applied?
>
Please resend with fixes tags.

thanks
