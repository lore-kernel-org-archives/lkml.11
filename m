Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA0BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 06:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiCQGNS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 02:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiCQGNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:13:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5461E99EF5;
        Wed, 16 Mar 2022 23:03:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qx21so8457865ejb.13;
        Wed, 16 Mar 2022 23:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOH6gnDuS8Igvj6VsPfk/9cEpfu0P7pulJAkbuWoKdM=;
        b=hck6V50rDYKiathOEJ+G1zkLJH45wzzmkmLCrHehJMfdjpSqCorl/p+7cUiHBXca50
         a/aBgfy+WZ8FzgDPZzT+rjJbwr/MlScONMNq+biaiH+XSrd1HFONeLQoUHYvkPvDImYt
         bkq7IqMCotphjYD2HuDSpGysixnmo8Z5fV7PF+KQVUFsRDnspid+VJCoMLuSJuHyi+r+
         uxp01xf3Dp5cf8SJs9CRMMzjH/cJn3POz+QoMW3enVNpK7J7vR1H3UxWbGFRbivFmZjw
         q+24gnsDa5fns6vkYUaet7g+Js/Ys4WEecvUwydGA82Vt6lWuV5eMA2PBJc5edkq+/aV
         JpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOH6gnDuS8Igvj6VsPfk/9cEpfu0P7pulJAkbuWoKdM=;
        b=RyRa7azFMF1hj7ykfAJr40jhemWCeOkJVrTQiN0VWyrLpW0hwdw2IfM72SrmX85Wai
         a9IzedLQcY42yc6ggD3FpF2GBrIVM3rPtZAz54yC7BQWQMaggRIZbf4nA9RdnRpu/9ny
         6YlJyuu71GSSVC1y/g461kGnsaepYfusAbsDaXysaP+7XcnSEN5Ch8q392UEVuKjy/eM
         UFWmfOf9/1ozCFbIAj4/p3467HwkiHdmT1xBn5qUEogzb/ql6OHIUv+09m/WW057kvQK
         UvWncKd04tH7C6rHkEzznOduOOQmMRD00kb6zuEaQnrQff9rFK/EsCHx8LRqIHf/1Co2
         zrqw==
X-Gm-Message-State: AOAM531w4ktRx/xfwlmZKLNxNa5azj4jdEtHlr4d0jr46TG844SIYNA4
        or71SLsKtcFkB3gbvYLduY7jodB1UuRBUNkXIXY=
X-Google-Smtp-Source: ABdhPJwuer1Z/hIDA7KkDvBu5GQcKq2//+8P1Fo9pzf3qOTSe7orgQqefd5ey+XG7caRb7yfRmbC6wGYuLJpn9uSrtA=
X-Received: by 2002:a17:906:2695:b0:6cf:e1b4:118b with SMTP id
 t21-20020a170906269500b006cfe1b4118bmr2845593ejc.348.1647496981212; Wed, 16
 Mar 2022 23:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220316063148.700769-1-imagedong@tencent.com>
 <20220316063148.700769-4-imagedong@tencent.com> <20220316201853.0734280f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <4315b50e-9077-cc4b-010b-b38a2fbb7168@kernel.org> <20220316210534.06b6cfe0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220316210534.06b6cfe0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 17 Mar 2022 14:02:49 +0800
Message-ID: <CADxym3Zqy1mQnRm5Ec9AfGy=abn0F1WJ_NSgxg-aqTWmKn=Qig@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: icmp: add reasons of the skb drops
 to icmp protocol
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, xeb@mail.ru,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Menglong Dong <imagedong@tencent.com>,
        Eric Dumazet <edumazet@google.com>, Martin Lau <kafai@fb.com>,
        Talal Ahmad <talalahmad@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Hao Peng <flyingpeng@tencent.com>,
        Mengen Sun <mengensun@tencent.com>, dongli.zhang@oracle.com,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Biao Jiang <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:05 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 16 Mar 2022 21:35:47 -0600 David Ahern wrote:
> > On 3/16/22 9:18 PM, Jakub Kicinski wrote:
> > >
> > > I guess this set raises the follow up question to Dave if adding
> > > drop reasons to places with MIB exception stats means improving
> > > the granularity or one MIB stat == one reason?
> >
> > There are a few examples where multiple MIB stats are bumped on a drop,
> > but the reason code should always be set based on first failure. Did you
> > mean something else with your question?
>
> I meant whether we want to differentiate between TYPE, and BROADCAST or
> whatever other possible invalid protocol cases we can get here or just
> dump them all into a single protocol error code.

Such as a SKB_DROP_REASON_PROTO_NOTSUPPORTED? and apply
it to 'GRE_VERSION' such cases too? Which means the data is not supported
by current protocol.
