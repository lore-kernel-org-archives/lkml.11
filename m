Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiBUS1s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:27:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiBUS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:26:08 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE84201BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:21:28 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p19so36100531ybc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTGQUw/yp62q+X56JGtbUwQRIOpOD9mgze5oP0/f6xw=;
        b=NXV6Evf7jjgKogMoqgQbDVvDcUXROXUScLt+D5JqzwjNDL7wVPSKNKK3s6iGi8XVbP
         1l4IWc351eU3pH6Xu57KseChgxMNU8VeHA1L1wHuuzxwdc0KwUxgIc2ESqPg2rvne2Uf
         5FpUqz/v63MRBWk4WfK0Nd+sHw5FAlIOfqyYa5x3gglejBieYHSQr9cUr9M9Bw0bc5/Y
         mhrga3LJHA/c3kUagQjUaK7J5dcKg3jtjUtXCl02MZ2ZpHkXXtMgpmLOzRV1Xa6u+t6T
         N9tZc43EGiV+7i6OEyVIQiZ1EiLc0mI9ZnEgfoF9dkoxp5SXJLmkUJajoydJ7ZbOSh9E
         PDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTGQUw/yp62q+X56JGtbUwQRIOpOD9mgze5oP0/f6xw=;
        b=L+O0jI0zVnYGLAKeYCapqJ3x6kFBPfB9Vj5CKWLOznuHa6Y1uyDKwiZ1fqP1rTo9VJ
         4hb7/+uoApPEdwpVAjQeZBeIH6FNF+yv0FwkGMAAlhSeno7Ahf0kXC+u/E4NAKVzr/1C
         BKC6QJimTWM9JjRrzBAcHtVnw/ioWMQLB05NpovrSuwpgaCPLQ2b/xBtbO7U2KrXL78K
         LT7mX5yBOcnAFVHA0ET/AC2j/is5Fsq7SFbcGR+VWKuoHnjY88sJQbpmVGglAZKGOT2h
         SR/EsLff6GNZIS3iS3bWmVFJqIaDI4JqNIy/UzVDGCW8MF1JLFhcI14ICAJwK8sIYRPR
         YeYQ==
X-Gm-Message-State: AOAM532l4Vz1H57EsPqQ1r+oUhF9DQb594x5rObbQ6diYkZmF54HoMRE
        LVkaUBejQDVLPihS/uds5HcOs4ZFGCq1ywh9ANn7tw==
X-Google-Smtp-Source: ABdhPJzNRa90uyyJMIA76Xf15WRYwqBQ25flbgB4wWQtOtY0TxsEegglKYN/6xNj2WZoJkEqodLLrnmc5prM1GBDeHQ=
X-Received: by 2002:a25:504c:0:b0:619:6279:88cb with SMTP id
 e73-20020a25504c000000b00619627988cbmr19649844ybb.55.1645467687690; Mon, 21
 Feb 2022 10:21:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgsMMuMP9_dWps7f25e6G628Hf7-B3hvSDvjhRXqVQvpg@mail.gmail.com>
 <8f331927-69d4-e4e7-22bc-c2a2a098dc1e@gmail.com> <CAHk-=wiAgNCLq2Lv4qu08P1SRv0D3mXLCqPq-XGJiTbGrP=omg@mail.gmail.com>
 <CANn89iJkTmDYb5h+ZwSyYEhEfr=jWmbPaVoLAnKkqW5VE47DXA@mail.gmail.com> <CAHk-=wigDNpiLAAS8M=1BUt3FCjWNA8RJr1KRQ=Jm_Q8xWBn-g@mail.gmail.com>
In-Reply-To: <CAHk-=wigDNpiLAAS8M=1BUt3FCjWNA8RJr1KRQ=Jm_Q8xWBn-g@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 21 Feb 2022 10:21:16 -0800
Message-ID: <CANn89iJ2tmou5RNqmL22EHf+D2dptJPgpOVufSFEyoeJujw1cw@mail.gmail.com>
Subject: Re: Linux 5.17-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Woody Suwalski <wsuwalski@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 21, 2022 at 10:02 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > I am pretty sure Pablo fixed this one week ago.
>
> .. looks about right. Apart from the "it was never sent to me, so -rc5
> ended up showing the problem" part.
>

Indeed, I personally these kinds of trivial fixes should be sent right away,
especially considering two bots complained about it.
