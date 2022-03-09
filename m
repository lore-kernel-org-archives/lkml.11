Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED9BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 22:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiCIWQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiCIWQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:16:43 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0319F954E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:15:43 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 25so5199767ljv.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qw8gxVd/jhZj3HT7A23dlpB9LW84F+FNi7JNdvrCukQ=;
        b=hfb8CzPyalPIpFuwiwa0XbPwPxNPzZJjxvpkX0YTX0v7YvhBIERsAprnsVo4Mi1DmR
         4qFwJ01VcC+MJzk9PZGJezEgtQV+T3wEqf8LNqSCwTbbfn6hWblrjmdv5juTbexxLXut
         AtIufaImJ0J1z49EJGYA2H1DuFgPj6qxEGoIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qw8gxVd/jhZj3HT7A23dlpB9LW84F+FNi7JNdvrCukQ=;
        b=1lh8APsq4y/xFy25eaKfIiDsFNCzyfT8cPU4/jtMW4nlJcMSeZux7pyCMZUqgSDtJF
         wVyFbBEdTx5LnzsHOdPo9FmzByZGz8+C5vd1EbWOWXevYmq03ILT8xqpiY8n2vTTWAWW
         4E38zIothSnIyDY7hL6DsNey5REJZ3/aLQDfgcDq0xdQ903QabO6I9tZq0PmFJ/+USgW
         vxBB2MzRw0U1g2X6B0g0qSeKUGcilBrIP/eqyq1hJ0v/uppGkoMzsGvamDavaY4NUH6B
         IbdDD0/NnH+Nbqrgv4+O/j387ozzHUqBG9VkW5H+j4LmMHXZKZ2kOhbdQA4r7RsVIwIF
         bwAg==
X-Gm-Message-State: AOAM532cgjmTYdS9Im12XgapAkBfUnAEAHTTu0/k0uNDYnryXr85NfZh
        xOLSGbRk4c9pkDv4wImX11mdwHY62xgSBE5y6uU=
X-Google-Smtp-Source: ABdhPJxeh+voifo1yoV1yIlorxbbFrgiUpqD1VoZvrLssq4G5EDCI/FZhdrO1R99/TaOORNNktBbtw==
X-Received: by 2002:a2e:980a:0:b0:241:c1e6:2664 with SMTP id a10-20020a2e980a000000b00241c1e62664mr1104995ljj.320.1646864141946;
        Wed, 09 Mar 2022 14:15:41 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id h14-20020a056512220e00b0044392581d44sm611804lfu.88.2022.03.09.14.15.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 14:15:40 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id bu29so6344384lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:15:39 -0800 (PST)
X-Received: by 2002:a05:6512:6c6:b0:447:ca34:b157 with SMTP id
 u6-20020a05651206c600b00447ca34b157mr1112657lff.435.1646864139462; Wed, 09
 Mar 2022 14:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20220309220726.1525113-1-nathan@kernel.org>
In-Reply-To: <20220309220726.1525113-1-nathan@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 14:15:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi23APrArHX7bcrvKBDZYpHXbeyEW7dRsirwoSPCKgqJg@mail.gmail.com>
Message-ID: <CAHk-=wi23APrArHX7bcrvKBDZYpHXbeyEW7dRsirwoSPCKgqJg@mail.gmail.com>
Subject: Re: [PATCH] ARM: Do not use NOCROSSREFS directive with ld.lld
To:     Nathan Chancellor <nathan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 2:11 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> It would be nice if this could be applied directly to unblock our CI if
> there are no objections.

Applied.

Greg - yet another small fixup. It's commit 36168e387fa7 in my tree.

                Linus
