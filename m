Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265EDC19F29
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 23:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbiHCXiw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 19:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiHCXit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:38:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6FC5C953
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 16:38:48 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e127so29932814yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tz/OiJMvaGAcCeuq23X8LcWOcGwQofI9LN2T94BECis=;
        b=TrdKVNTVmoj1qjug6322BkTsWRYmWEkRiUaGMCxrLZqf5RBZN07SDs7trA1kTCqzIF
         aZJZr4Kg3rR0ihX4x61zMQq58cn72dqN5seQRt0FrFAcsTRprLofL8cQqWoUgOaRF1cm
         LDBpubL6G7YQ02CHe6GqktddjjQOn2Z4xzO7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tz/OiJMvaGAcCeuq23X8LcWOcGwQofI9LN2T94BECis=;
        b=zM7VcVYlTVZ+7KFBLx5lEUIhF1FS7fNL7OVcvQcpbyLRuj8ENXeafNR5JaeqX3/ZhH
         AIwN6Xd1OW1HvGcF6zlzcEEnJvoLHuvOjS6wvS9J5m/OcQFeoBYlw5HdBZ1KluKpcx0v
         QO6ZhEREK9fGgDlzmPIiHbhScjNSvInYdMX5uk49CTfJPBLLwlCjhJqCsGFw1hj1CQIN
         AwjvI66P5hc/lQc/HA+D5yJfYGZJm5xzPkkDLOm3BdF6TqP3vRlr78YNCR8i3D3lWA2s
         5DAjWGCcSR5rwO/tgGCxczCI5Nj5kz4oK1kjVDktsgXlJWx77BKEZsNdD5vwwug0gZFU
         IZ6g==
X-Gm-Message-State: ACgBeo3xuJtMa8b0GPp2ea9iGx0toUAEsyU9KU+G+3jJfh8h1UACvnkb
        ThVBcvN242nOQb+0Edc3hMY5f6TVUq3Xrymi9iLF5g==
X-Google-Smtp-Source: AA6agR7cf+R7Yn1l+n+/4LnB7dhz82lwgLpmUJ6FIaVZi1PrBPwB2UQ5t0KnOpekkCQJvdkqvGz7S8l8vu/XgVJ+ReE=
X-Received: by 2002:a25:6908:0:b0:67a:6cf9:52e0 with SMTP id
 e8-20020a256908000000b0067a6cf952e0mr4348359ybc.62.1659569927631; Wed, 03 Aug
 2022 16:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <YtB45Lte5UhlEE6y@redhat.com> <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
 <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com> <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
 <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com>
 <Yun4LH+StcuBXRtO@sol.localdomain> <CAONX=-esLr5bGUks_a8wQBky37NnCawh2eOMemYg32HcPA7pmA@mail.gmail.com>
 <Yuq9jhxb+WgO55KJ@gmail.com> <CAONX=-dCrJabyvt2S24kEJi38Pbuzj_4kvugoF_75PWV69bNJw@mail.gmail.com>
 <YurtfvdeYh0kLd+8@gmail.com>
In-Reply-To: <YurtfvdeYh0kLd+8@gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Thu, 4 Aug 2022 09:38:36 +1000
Message-ID: <CAONX=-e1NcUmJEzajkpCsOVYOfmfMmKKfOB0Bp6UTag3G77yAQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow device open
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Zdenek Kabelac <zdenek.kabelac@gmail.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I thought you were trying to defend against path traversal attacks, not
> arbitrary code execution?  If your threat model includes arbitrary code
> execution by root, you really need to be using SELinux.
Hm, this is actually a very good point which we somehow missed, hm.
Thanks for pointing that out, let me think on that
