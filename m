Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0664C00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 18:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbiHHSrl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 14:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiHHSrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:47:39 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E48B28B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:47:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v2so5307515lfi.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spLx4BmS0ESQuFMLlfBbiEsVcFilYdm6jlWZCb/lP3E=;
        b=rIwKG1dyJQEyjuMi1QLgibUoOzQIG1Och0sDLUfq6AwqMRaKay8U1ROjw0BPOQfccD
         ypVPSWEgS6aO1jHxtVHzma4sMfFhmKGIgZNTM7IWPQNYoO4/hIjZB2MSbV2LD4ISmLEB
         2rJQgmWnWMHsqHk6bQn7cQZ6+BSlQmP9Y0iTz5lgBRmV6cZAQCeUKSfbtAejOW7C6nuj
         JBiVhW467pd3ToP3UI/g16Cw7hsMJZVfnWvys3vBRc+1Paf+Z5kHa1ZWZ7EYlby7eDtl
         yc03WR8YamDZ8u/kRiY26QQErFvgCf1qmea0t+hHyYMTfNjhwVvvFAYfkFS0YuCx6xOX
         4K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spLx4BmS0ESQuFMLlfBbiEsVcFilYdm6jlWZCb/lP3E=;
        b=tBE9hKsEUFVylIcn+Apwr83+7Tt2YoHwgPmh0rYcfTYiZmibDmC9+v4THh8Ohpqd2z
         4/xcSV5O0VWUUkwJIXrCNowjhMeZjTunXSRmOQWFYU+Qa8JgruRUg7wGQSyXTZBYtvzb
         sC9dBdLQO3qw03yN5bN8C/9o0BcYPXur0uNmEKojdr0tUzbqWEP15Id84XhFeBm23fLT
         MLX1HhzLMLktQfBcAccZ91rC31HMy9yJC5SnT+ssne08JabJnxmYTVznTREEQMiRlSfv
         9PgkKIyY5u6nM/p3aPLw4q5HQGoF82PXJcCN5eOI4ZDbh5D/QxzNwB3WYIKL0imwC2Rb
         qglw==
X-Gm-Message-State: ACgBeo0J3K8wRYJDaNtg6T8zGvlftPkTiTCePKzpLuG0JgRTRAv/KDy9
        k27ItDoDAdvZL+jbEIN/lbjE9R1Yt0o5CsZuR8zmJA==
X-Google-Smtp-Source: AA6agR7JGTS75eRLb3PpWY05edC4/z5G8WRhg3NMJzHeWfFvV+hZJIJ99SEIAlSxZ00vAdN1IrpEj4h4o4KGIuJ5bqw=
X-Received: by 2002:ac2:4f03:0:b0:48a:6061:bd8e with SMTP id
 k3-20020ac24f03000000b0048a6061bd8emr7629025lfr.647.1659984455809; Mon, 08
 Aug 2022 11:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652074503.git.christophe.leroy@csgroup.eu> <96f53c237316dab4b1b8c682685266faa92da816.1652074503.git.christophe.leroy@csgroup.eu>
In-Reply-To: <96f53c237316dab4b1b8c682685266faa92da816.1652074503.git.christophe.leroy@csgroup.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Aug 2022 11:47:24 -0700
Message-ID: <CAKwvOd=VBnx63Gj1vTH-8tR50Zd1r50x+NS8JRc4nXARaC2FcQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/25] powerpc/ftrace: Make __ftrace_make_{nop/call}()
 common to PPC32 and PPC64
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     llvm@lists.linux.dev, nathan@kernel.org, omosnacek@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christ...that's not what I meant to send; sorry, mutt is giving me
bizarro errors today so I can't insert myself into threads using the
usual incantation I have in the past.  What I meant to send was:

Christophe,
Ondrej reported a regression with ftrace when building w/ clang
bisected to this commit. Can you PTAL?
https://github.com/ClangBuiltLinux/linux/issues/1682

Thanks,
~Nick
