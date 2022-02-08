Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA9C43217
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 22:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387358AbiBHWbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386345AbiBHUNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:13:13 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70E3C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 12:13:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id y3so1064262ejf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 12:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQ3HZkUFGAf4B+2eLQfeREueBSNbdWDQUKhjsxyVA9Y=;
        b=IvbPGlJLCDvnlk6W/5N307Vj0Cm+PzEP9jec7BmAcDnlMon9ab67PPDjmZcRICbjTH
         rKM2s+/SwTSAwGzfitajCFqK9Nf5SlTKKmNKlQa6xSEMasorGK7tnl3j/HCG0A9nJzNJ
         ymnndRCWJA1oN7PYDaCiRd5w7yksrWTQlj054=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQ3HZkUFGAf4B+2eLQfeREueBSNbdWDQUKhjsxyVA9Y=;
        b=MPWxY4jzq6ocjwzlhPwKVTxZN3F47bvPOWE48A/5gJOAD54KyaigWXG/0jVde3LKyW
         T2KJTxmfWUuezdczEvOEvk8g+vLaJoL1ZW3/CiR6H6hq6xYNJPU/W6pmfUPjskuXs9Hf
         JtzdN4qgTAQiTm+vNop3zJsqJJM6xC2ubOLs38BpryQi9z1HH0jLeio7Y5pVOiJKb7kr
         QUvSuLXr3x6Xmq847Q8D9pfOoqXm1Q56QvedSJ7ZnaEc8VuEw74MW3MxriDon0eKnxTq
         8paba/LES6wJ/xdl7Mbl05llgPTq2yd02xS61RzYRlAO6X6uhxsBMy7sTI5LBlEeOHKf
         QDLg==
X-Gm-Message-State: AOAM531SNTAfTaWGAtiIiLx8KTbhvgzpEWzxXl5t4lFw5n8d4SI9xxPn
        sF2fOeWbIoPLV7PdHRVG0OFrkD/24ODuazq9
X-Google-Smtp-Source: ABdhPJwSnLMA66gTJsyzafQPuJckf6vLo1exMCnzwaFIckZnSIVD4saeoOPFrWfDDIzJjF4IcRAmsA==
X-Received: by 2002:a17:906:af69:: with SMTP id os9mr5082048ejb.468.1644351191090;
        Tue, 08 Feb 2022 12:13:11 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id zc8sm2463510ejb.150.2022.02.08.12.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 12:13:10 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id i14so323095wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 12:13:10 -0800 (PST)
X-Received: by 2002:adf:d087:: with SMTP id y7mr4716600wrh.274.1644351190120;
 Tue, 08 Feb 2022 12:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20220208194800.482704-1-anna@kernel.org>
In-Reply-To: <20220208194800.482704-1-anna@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Feb 2022 12:12:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxJC==PiWer8UJTOGhQBSKWzY6f78qkaUvfK-5e9H-Yw@mail.gmail.com>
Message-ID: <CAHk-=whxJC==PiWer8UJTOGhQBSKWzY6f78qkaUvfK-5e9H-Yw@mail.gmail.com>
Subject: Re: [GIT PULL] Please Pull NFS Client Bugfixes for Linux v5.17-rc
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 11:48 AM <anna@kernel.org> wrote:
>
>   git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.17-2

Thanks, pulled.

And this email setup works well and has proper dkim and so hopefully
won't have the spam issue that your previous one had.

But can I please ask you to actually put your whole name in the
"From:" field, not just "anna@kernel.org"? As is, it just looked a bit
like spam in my (non-spam) inbox because I don't see your real name in
the mail index..

I suspect that's mainly a git-send-email config thing, or whatever you
ended up sending this.

                Linus
