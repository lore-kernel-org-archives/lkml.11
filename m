Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B8AC433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 15:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiDHPQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiDHPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C801226DE;
        Fri,  8 Apr 2022 08:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618D961F2B;
        Fri,  8 Apr 2022 15:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAD2C385A6;
        Fri,  8 Apr 2022 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649430878;
        bh=+Kufa04u/zTqHEB/EmRSK2XieqNMNPkuGKRCwWhmIf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qSsEHIx6qX0TF3sqA70nkE93eIftID8aXw3VXGlaTA9glKX+NrCQwnOoCdqohCBHO
         L62NtdkZq9FDH7D7KUrv46V10iu8lFvlr7KpO2sPIyusvIumFcsBBY+ztiigX1yB/m
         o/yeqWIoJxHAhwz6cIdPw9zbx5y++KIdNYTSIs4ukpcr0GGseJGQXzQhnoyJc/Hz8d
         KD8ywBQXMtT1ld+s4E+A/QhGfrXsO8oiWpLmUusqceVdoS6xU9r1O0jg5sIHXS9N3l
         EZSYzO3xMOIn7pGUExBYtHGi2yX1vAxTb5CfKIRKEv4nCcrS4myHWe8UK15X4MpsCl
         qk9WGH5ZOE7KQ==
Received: by mail-io1-f50.google.com with SMTP id e22so10921391ioe.11;
        Fri, 08 Apr 2022 08:14:38 -0700 (PDT)
X-Gm-Message-State: AOAM531o12EPDZIfm3boq/6D1nYBiMSK8PrGuVoICJ/IuwyE7z9y6lhS
        1VIdtYUbBTCV2+ooAQHSIo7DJ9WXXGxgHDCcfA==
X-Google-Smtp-Source: ABdhPJyvoPkgbO5fUHoeXR4IWB1C6fLbSqDw3ETopX4sc2/uj7NKpf9ehCnpwiEK3iKvALIDOsmDbC8OtHxAVtJOJ20=
X-Received: by 2002:a02:cc42:0:b0:324:272f:d6c8 with SMTP id
 i2-20020a02cc42000000b00324272fd6c8mr3839994jaq.247.1649430877907; Fri, 08
 Apr 2022 08:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <35ceac23-2841-7def-d963-484d1a489836@csgroup.eu>
In-Reply-To: <35ceac23-2841-7def-d963-484d1a489836@csgroup.eu>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 8 Apr 2022 10:14:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJwcS5VhhOwqV7258YC2zvb759UBt5cusn7f_niswdxbA@mail.gmail.com>
Message-ID: <CAL_JsqJwcS5VhhOwqV7258YC2zvb759UBt5cusn7f_niswdxbA@mail.gmail.com>
Subject: Re: What means "sysfs: cannot create duplicate filename '/devices/platform/ff000100.localbus/d0000044.gpio-controller'"
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 3:16 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi,
>
> During boot I'm getting "sysfs: cannot create duplicate filename
> '/devices/platform/ff000100.localbus/d0000044.gpio-controller'"
>
> Below is a grep of "d0000044.gpio-controller" in the log.
>
> Any of what the problem can be and what I have to look for and do to
> avoid it ?

Do you have 2 DT nodes at the same address?

If not maybe something with fw_devlink is screwing up. Can you try
disabling (there's a cmdline option).

Rob
