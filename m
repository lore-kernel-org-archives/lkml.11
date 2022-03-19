Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D54FC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Mar 2022 10:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbiCSKgO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Mar 2022 06:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiCSKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 06:36:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E011DDFF9;
        Sat, 19 Mar 2022 03:34:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j15so7207380eje.9;
        Sat, 19 Mar 2022 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yzSwQ+aK8F7alc5D4LFhyK3CHYBa0cHOSVs8XZnnUk=;
        b=HJPTyXg12nBvM05kaPUiHBJxd9M28E/YPUGYW8bGXBAdZYGUGQR48nT3LhiKMghPs3
         NTU2FOQvh1C8X87UZOIgR/dm24RoyTdFCGdD5ZVbRYEDw49kopdUG+Sb1lTj3RlZhe95
         eFl7xw46AHKWsT7ObV6AEn97nNdBDQoW1ZbvCpa/eqzMZm+Ju++8g4Ta/l6E172uzmGV
         c/tluTo+vKkEXv8RaJSL3quryrzDtbJz+lXWGIrR3BBYoi6C7VFDf5kIIm82a23Z8FxJ
         uJSwhhkRmnP1dbDXqDuTblLRbxaLkVgs4nS66dWd03lApNN/0afcqkWIc7ck+zaJPkMY
         +M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yzSwQ+aK8F7alc5D4LFhyK3CHYBa0cHOSVs8XZnnUk=;
        b=NAFJncL3jnV8gK96RCP+Wv3ukla8sNSWXGe23jNSR/nTuG/WpbcIVG+uCbGwWKSmLe
         GrlHkLd6CQLrogwmVeDytTIxciA5ftlKElNtEUQBZhryAJulYxb1Ii3kIskTI7Z+pCQy
         c2JgtMUGY4QDqwVtU/afXz/jRusPmIM7MlNu/JSFdf8HROIwfJbt13gr0jWkZC+AAp9z
         5suxRuZCK3eWhSJ3kysciopX9KUrR3fapTgvqhyl90jyfng+VOy4v3XXeNBzfIq/9MBq
         /HxrQUWCjLuJVKQsHFLRmvwSZrjq7euFueUJJXvA7hc+ULkIARVNSAL77nJZx/9roxgh
         6Zxg==
X-Gm-Message-State: AOAM531MvnJCUPX+znmeL/dWN1faNrsMbbq74OQ4aCvd61140J46kEWl
        kKukCW5EmYW3QaDTDu4+Ftav28EOLuYB9ZM10/20jYc5rnY=
X-Google-Smtp-Source: ABdhPJztrREL1ylmCH4+y++g7PpfbZG9f4sAnuOldGLAaLH1NhlBZGS+l0eyN2NCyywt6BTBG9Oa01d71jMGZvda9Mg=
X-Received: by 2002:a17:906:f857:b0:6df:ae2d:73a0 with SMTP id
 ks23-20020a170906f85700b006dfae2d73a0mr8159457ejb.614.1647686090905; Sat, 19
 Mar 2022 03:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220319090142.137998-1-zhouzhouyi@gmail.com> <20220319100443.GA13956@breakpoint.cc>
In-Reply-To: <20220319100443.GA13956@breakpoint.cc>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 19 Mar 2022 18:34:39 +0800
Message-ID: <CAABZP2z6=4bC7qzDdPVjFB10NFioqtspXGTgw_=62o29=VFa+w@mail.gmail.com>
Subject: Re: [PATCH] net:ipv4: send an ack when seg.ack > snd.nxt
To:     Florian Westphal <fw@strlen.de>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, Jakub Kicinski <kuba@kernel.org>,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wei Xu <xuweihf@ustc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Florian

Thank you for reviewing my patch ;-)

On Sat, Mar 19, 2022 at 6:04 PM Florian Westphal <fw@strlen.de> wrote:
>
> zhouzhouyi@gmail.com <zhouzhouyi@gmail.com> wrote:
> > -     if (after(ack, tp->snd_nxt))
> > +     if (after(ack, tp->snd_nxt)) {
> > +             tcp_send_ack(sk);
> >               return -1;
> > +     }
>
> If we really need to do this we need to
>   if (!(flag & FLAG_NO_CHALLENGE_ACK))
Yes, we need to check FLAG_NO_CHALLENGE_ACK here to avoid two acks.
>         tcp_send_challenge_ack(sk);
>
> ... else this might result in two acks?
> Whats the problem thats being fixed here?
We fix the code to let it match what RFC 793 page 72 has described. I
guess this is also what the intermediate internet devices (routers,
firewalls for example) expect us to do ;-)

Thanks again
Zhouyi
