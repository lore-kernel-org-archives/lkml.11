Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D9AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 01:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbiCXBnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346216AbiCXBnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:43:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47786931BA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:41:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 25so4247237ljv.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VmCNpUktJfhcqAvDV0WxH3zaT4vDImvmvOoWvKF5Gs=;
        b=UW43zwyr7VzAWy0J7pa4I6DoGCPEoRpfqb5FRW/fgJtPoxaaWAvDDDKni4bVmn2CF7
         FoneE+ygtfrCccxNCf0tihRpQDykhG7fSiKsrY9JTHmw2Y8gDqaIcBn8lATXk5HEBP5w
         6YLjgN/7mQ4ZVp+a/2pjFriUi925WrG0ZXVCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VmCNpUktJfhcqAvDV0WxH3zaT4vDImvmvOoWvKF5Gs=;
        b=0yQemasrQqNBcWY2Gb5+j9FxO5v95LwbytgMElyDX/0vYS24P/cK0AW/aOXTCnBb0M
         +f9HbMw8vLfzSTVrgHUWWKHqvrF5mqTpynJM1gmC8VUMFLio/7iH8LweRYHP0JNlMp3T
         KRUaj9K/Unh9qbrQiHrVZZhF8dGMFhOEVtfym9GeEF9cXFo652S3Ugr41P7qjEor5Jh+
         rWTzehXH2QgomfLXi1hYMo9YfY23D5L5RvU8J1ERgBU3F3eMATaU/d1+y9sk/owT/W81
         E9Tc0LIJd3rp6U6t0FkaadEI9LJauNFh+ZqJIyAJD+PAI+M4t2hcV5jXMPeeHBAFehB2
         HTBQ==
X-Gm-Message-State: AOAM5325uHkkdDq0kFN5UfpzpgrUTqGZaKiraMIBA2yUupWjUB6MetFU
        Gy8fe9sWDpL8aIUjCU5dwvvpMfU2v1FYqpNX1SE=
X-Google-Smtp-Source: ABdhPJzgPn7+l//sC8+ff0+SLUnmdM2qluZKvfg7uWkdeTGxC+ijJAK7vKjhc3vrkzktV2yKqi84vQ==
X-Received: by 2002:a2e:5318:0:b0:249:8375:81ab with SMTP id h24-20020a2e5318000000b00249837581abmr2259034ljb.243.1648086104252;
        Wed, 23 Mar 2022 18:41:44 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 206-20020a2e09d7000000b00247eb27d491sm150658ljj.103.2022.03.23.18.41.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 18:41:43 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id u3so4306697ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:41:43 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr2372025lji.291.1648086103115; Wed, 23
 Mar 2022 18:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a29JCfCNWrJ-x7S+kewcSBpeguyo8fmUTt_V4gfrW3=HA@mail.gmail.com>
 <CAK8P3a182FVbZ5QfVhMr20nxQN31fK29Csr_GRp_WpFoBFEPzQ@mail.gmail.com> <CAK8P3a1oGWkyPHZ-gV3pP94hOrJJFBsvvkuzzXBhaYpbzEGR5w@mail.gmail.com>
In-Reply-To: <CAK8P3a1oGWkyPHZ-gV3pP94hOrJJFBsvvkuzzXBhaYpbzEGR5w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 18:41:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLyCDkXfMoAYFWX4qbLg7KajXiQWLNhfcaN5EB3HuO5w@mail.gmail.com>
Message-ID: <CAHk-=whLyCDkXfMoAYFWX4qbLg7KajXiQWLNhfcaN5EB3HuO5w@mail.gmail.com>
Subject: Re: [GIT PULL 4/4] ARM: DT updates for 5.18
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 4:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> The new machines are really too many to list, but I'll do it anyway:

Heh.

                   Linus
