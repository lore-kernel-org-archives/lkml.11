Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 06:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiDGGID (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 02:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiDGGH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:07:56 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A89176658
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:05:55 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2eb3db5b172so50413887b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBaUL5Qo8tgk860spwGfzbrtob87B4KJ2+FsDkmq6/U=;
        b=qLcr54HTJ7zWVVtv7O9dWIHN7PZYJyY8/tEUmzyxotg68nszvqSwd+5tHxUsZvm8/l
         0GUi2h+qNt03C1iiikBD8KDPlJWCijpyk3ldmOTTIbhI2B9P2xQbgHyedekAde71w4En
         8DHFBqh4c49PopW448YZ55FUTAx8AIFgu0kMd+XFX4UhcApLSdurXPywGjOss0wOlcjc
         FT/qWyt0WLF+mdF6vKzrKWdPcTuHuuB+6v3Uq6GccKEf0/sXKPUBKg1yXmsk+gX857jz
         n5GjKhToQyh8tH/2b3rWt0L2jVCVvxbVzGGb4IO0qfsabjq+wMzdHSerpXPS01ccNeFD
         58qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBaUL5Qo8tgk860spwGfzbrtob87B4KJ2+FsDkmq6/U=;
        b=ReEMZp+fHR/Wi/sMkkl8D0t24KpmbNQWGfplxy/ZebR8OQPmvzbMpXhr4HAVSU27dz
         jMlOgV5FbAxUci1Vxo4YL/OUobfHRtcVFPJ4+89hFGh+ipfX0nce/1bHSvgNQ8DyWHma
         j219ehRHOmzz9JFXsASQq1E9aoF+8KZQhvY4YoweQQR7vSo8YjGnqLsXpRvA7U9Ffjqx
         pA3ib9jbXTY0BqWZCSaQsLHJsUENjCsYDzvRPvZgbQ7yGeM1zZt+K96muY2flnrX+PJ4
         pKZ+XJ3qBWOBRcXr9yQsO7BzloytKUZcF7YjXJcf4z/fm9HfmDAyM1AoHZ9PJ+nNgzvp
         Djug==
X-Gm-Message-State: AOAM530UF7Jbquj6OkjJGsZifrItneulXzmJ9x0Hp7zrutxh9CgJHkUI
        AgOVGuzwIPRueH9t45BH23O68SG+XBK5YBTja9aIdw==
X-Google-Smtp-Source: ABdhPJx+EgZFFeKjHLxz2hPDM7gYT118ppvd1ZdSuEtU9lAgV0Dmmv92dM4YOv0M+LTLXoVDQFgCZJlvn9MDGZNDDLA=
X-Received: by 2002:a81:4f87:0:b0:2e5:dc8f:b4e with SMTP id
 d129-20020a814f87000000b002e5dc8f0b4emr9600169ywb.467.1649311554173; Wed, 06
 Apr 2022 23:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220406010956.19656-1-jacky_gam_2001@163.com>
In-Reply-To: <20220406010956.19656-1-jacky_gam_2001@163.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Apr 2022 23:05:42 -0700
Message-ID: <CANn89iKXK6m45eBDCDw8Pij1H=iybZTTi2Yf9DFYu96KDpnyPA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Add tracepoint for tcp_set_ca_state
To:     jackygam2001 <jacky_gam_2001@163.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        ping.gan@dell.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 6:12 PM jackygam2001 <jacky_gam_2001@163.com> wrote:
>
> From: Ping Gan <jacky_gam_2001@163.com>
>
> The congestion status of a tcp flow may be updated since there
> is congestion between tcp sender and receiver. It makes sense to
> add tracepoint for congestion status set function to summate cc
> status duration and evaluate the performance of network
> and congestion algorithm. the backgound of this patch is below.
>
> Link: https://github.com/iovisor/bcc/pull/3899
>
> Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
> ---

This seems good to me, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>
