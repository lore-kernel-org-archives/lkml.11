Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09367C3F6B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 20:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbiHXUun (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 16:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiHXUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:50:39 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CD86DAC6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:50:38 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so12569734otd.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KduZjIEyBxkzWgXFN93eLdrigURNo60WLuJ3gbVZ7XY=;
        b=HzD4lZ/6vc6C1WbqLgNeBjsTawvUPrh+Xj9kvCaukUs4HQ4qPkl3iXv/4oz9z8HwXo
         ECVxp5rH4cZomOeGqhdJQD8ko317eSJ1CyxlRlohPXJiVaA5x1hshUDuqSdO4cmtUGMW
         CNqIz6REQRw99lwDp8gd7kPHARUS2DCtzdD4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KduZjIEyBxkzWgXFN93eLdrigURNo60WLuJ3gbVZ7XY=;
        b=MHKv6s7EDaLpRxRF5sWHlAy+mWzCEK5lMfB+6O2ytb/S6181jyLJOcKXhniqu5/nu3
         C3lW5jIOAPne+O3zdkT28CXa1lVtfJapGU+7n4UQKFOaIuRNz8sZBbPjv2TfHWd9r546
         gUMwaLAyRMOVgDVl58XT5RxiU9mAfmk6Y4aGBaEvk7Er+7hzO44w9PFE+6jckIIp2D6H
         H1wyAWQxwsXdhB2lLMYIgqE5p22yDRrSRK6I2v3SangMiU4yboaqVYb2jqcpn/OIndns
         XzElKSQ3K20KnBN2kQjzqM0LjN7ggFQdW2p2z8VXYDt8bMWKmkbic0r+JZLbF4KL5A60
         0syA==
X-Gm-Message-State: ACgBeo2wUfN/v/XkGrlrZVJlG+v7t2wl3S+Y1OtGKEgIh6KTWjuYhqQE
        X+h/E8sGEl/P0MBBm2yVD1bz0XWA07ZruA==
X-Google-Smtp-Source: AA6agR4vspImuPIuslf7CkIX4jcmKqTPwy04foecuJWtpJVBDH3m127MNH+jd0Ef+JUQ+aVJl3sSqw==
X-Received: by 2002:a05:6830:18fa:b0:638:d46c:1374 with SMTP id d26-20020a05683018fa00b00638d46c1374mr229360otf.142.1661374237882;
        Wed, 24 Aug 2022 13:50:37 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id z24-20020a4a8e58000000b004357ccfc8bfsm4096768ook.7.2022.08.24.13.50.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 13:50:37 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id a133so12993359oif.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:50:37 -0700 (PDT)
X-Received: by 2002:a05:6808:23c4:b0:344:e426:d2a7 with SMTP id
 bq4-20020a05680823c400b00344e426d2a7mr4087711oib.232.1661373740120; Wed, 24
 Aug 2022 13:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661252818.git.duoming@zju.edu.cn>
In-Reply-To: <cover.1661252818.git.duoming@zju.edu.cn>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 24 Aug 2022 13:42:09 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNf5JV9mj8mbm1OGZ_zd4d8srFc=E++Amg4MoQjqjS_TA@mail.gmail.com>
Message-ID: <CA+ASDXNf5JV9mj8mbm1OGZ_zd4d8srFc=E++Amg4MoQjqjS_TA@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Add new APIs of devcoredump and fix bugs
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>, kvalo@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 4:21 AM Duoming Zhou <duoming@zju.edu.cn> wrote:
>
> The first patch adds new APIs to support migration of users
> from old device coredump related APIs.
>
> The second patch fix sleep in atomic context bugs of mwifiex
> caused by dev_coredumpv().
>
> Duoming Zhou (2):
>   devcoredump: add new APIs to support migration of users from old
>     device coredump related APIs
>   mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv

I would have expected a third patch in here, that actually converts
existing users. Then in the following release cycle, clean up any new
users of the old API that pop up in the meantime and drop the old API.

But I'll defer to the people who would actually be merging your code.
Technically it could also work to simply provide the API this cycle,
and convert everyone in the next.

Brian
