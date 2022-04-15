Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5861C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 17:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245708AbiDORu6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiDORuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:50:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73296BCB40
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:48:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w19so747291lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pxlOZRBuJWC6Ej+jZ14mKMuVx9qkJWEg3X0ZwZTkhPc=;
        b=AGjh7x15wO41Vm7WZk3zze/8MHMZTgYGS5S5m/PUK7NM0u25WdnmOMU5S7AYGh+Yhu
         qDAG4TaukWed4uzSQH6i5BnUIT5PQHU/O/6gsCCN77seEqq/adMEjId2KSQq2ozkwymU
         bY5pqHKLvU4229uoaKMBL0Cg3oAEGl/tazNw2kNNB4d/V54Vr0FLf7533qnm/JP7jHVX
         tghwr3seWFTq32gAp/B7rx9QmN+5xMLaezd0VHafXZpHs//2CSIYl7S1/POTMDNz8j+M
         A6kxHYpmSV8JsNmpZ3CJDOVaoEKdIRmv2RWV2Uudy6pCbBmemj+X/5ZAZx5fyR3FaAvs
         hejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pxlOZRBuJWC6Ej+jZ14mKMuVx9qkJWEg3X0ZwZTkhPc=;
        b=T45I4h3zGR6fGJHN62CmArsCLlEU/VslveU/yprqxYZFHof4ijNrI9KD3ZJiJwoEJs
         5VusuUYk+V4OehMnqRECcqAnyvzK4OZE1/KOp76wSAuKnhDV0XqPQ/4/+i4P/AgUZM59
         NrXFko7ov9a2nOCHHeS7NAHyJVEncQsG7Jp04h2GYi7zaicxs2cgKb4sCHB5S/2BlgXi
         l8xzQHgsvLJeVpB3JUSKRQoCyRO8c1HADknR7AJOydiQfcuvivvQ1e8TnAsJpJqmh3dc
         XDeVfvwaLf/GNe9Ynx98/TuCW2M3aJC9PcZKQgRGp8l8eXuNDOQae7Yut8uGVfHW084+
         IFBA==
X-Gm-Message-State: AOAM530yx4sd4Da4FLe86ZlHsOF7AnPUOrZUngr+vm+R+5jzXWicbNeA
        h7UZtvsrsNiYz/kBn2rszu/FtL7Gj/wc6dhGHSvyZm8xsw6wLw==
X-Google-Smtp-Source: ABdhPJw/s+OvUlN+j11st5pHaviz8KqPPDcqLqJIqRUZcwXRtBQNT3E9aXGVOY5+ri72dswWY94BRsMwknx3r3fvgS4=
X-Received: by 2002:a2e:8650:0:b0:24b:5309:352f with SMTP id
 i16-20020a2e8650000000b0024b5309352fmr137955ljj.472.1650044904482; Fri, 15
 Apr 2022 10:48:24 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Apr 2022 10:48:13 -0700
Message-ID: <CAKwvOdmwyFDYKMpq0dcvbq06drtZonpNJ3PqLx2RMBE00beHZA@mail.gmail.com>
Subject: plumbers session on syscall wrapping and kernel header libc circular depdence?
To:     Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian, Arnd, and Masahiro,
Jose and I are currently in the planning process to put together a
Kernel+Toolchain microconference track at Linux Plumbers Conference
this year (Sept 12-14) in Dublin, Ireland.

Would you all be interested in a session (if you're planning on
attending) discussing syscall wrapping for libc's and UAPI circular
dependency on the libc?

Masahiro and I were recently discussing the feasibility of building
the kernel UAPI header tests with -nostdinc, but there are some
interesting complications perhaps worth sharing with others?
-- 
Thanks,
~Nick Desaulniers
