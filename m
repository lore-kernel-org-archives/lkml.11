Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C912EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 12:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350177AbiDZMqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350176AbiDZMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:46:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D526179E88
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:42:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so8916313edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6idSsBE4s9Qn9LKOd9OqUBxM1sdnuFs7ORWkA+7A74=;
        b=c+/ElPomAoi5ALGJ65fOGERmODHjI9yROekwY6i/fJVcpOqZQX1HbO56eTOrix+Hg3
         Yb/bInAxZBdub64ffByXoqjdeuPLumYWSZvY5W1mPGqvzyW/7aqyxgJIW4omsB5SC2PD
         c13Uv1YOnnEJW8sv3LF9LIOWyNTezrlXfg2fXiIeJ3sySwCYcwbzrxQm6KovxNx//ey4
         bdSoI6/kcZFqZudjdMM+TgUiStdeUIUVC9BBILNzJtXFIqwuAVp5Y2w3nYc726OZWdh1
         O7iYTqAhkNB8U5UbbZW5kSNJ/K48ZkDoZIyLUegBp9kPv1nIfoyK+Hfy7Snz9jjBX1cw
         XyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6idSsBE4s9Qn9LKOd9OqUBxM1sdnuFs7ORWkA+7A74=;
        b=crHu7jllRAkl3aCRRiwfdwfLn6EklPKeL+GoOjJOa8lT4MqRPvST5gffC5xoWV266i
         ePgS60NVRYfl+QD4k8PevOeen3KbOyTSOvYJn2yaEGziUiezM/GxajrmL9L1j8IelJVr
         FBGsxoy+8yzm3zr9MMHtHS0JzlA3R9hbA9JjANDoUzOwpofLQ9vJ+TzFBPaQxjGxBCsR
         WrrPHfKFBGqeyt8OxG8GO1gPmLoDHf8rB4ZG1axGagMTtYguXBS5Q5iWoVQ7va3ujC6k
         XHSqZeLcnKoho3XUhSbrE44Zbe/SorDyazHU0twTvfgUJeq0RY+a8PjuLbJCvVEVajg2
         xe1Q==
X-Gm-Message-State: AOAM533avI7QZOO3Enbgq+A8tmNrR4Mn16IMmDDaV59Bm7z9F0VjH4+w
        aIk0XNxgRXOiMXk2TaAKbzGHg4Nxqi5naGPAczMVNoyjhVQ=
X-Google-Smtp-Source: ABdhPJyqH5kCE6sQVhsfUeIoDwi2MnR8OMOBFkqTD9nFnCle9xl4NcSkY/u0xOdUxL4Wl5vy9q/E3mt+VCskbEd4Eug=
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id
 f1-20020a056402194100b004132b5f9074mr24260778edz.414.1650976972972; Tue, 26
 Apr 2022 05:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220425180540.880632-1-jcmvbkbc@gmail.com> <63deb092-4002-d798-410e-1db2081f0ef8@arm.com>
In-Reply-To: <63deb092-4002-d798-410e-1db2081f0ef8@arm.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 26 Apr 2022 05:42:41 -0700
Message-ID: <CAMo8BfKe0WLOaCiDopyr-JH6JSG2X0FTMDgON=KynKdyYt4L7A@mail.gmail.com>
Subject: Re: [PATCH] xtensa: enable ARCH_HAS_DEBUG_VM_PGTABLE
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman,

On Mon, Apr 25, 2022 at 11:07 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> Thanks for the patch. Just wondering if you ran with different config
> options (which might impact test case selection) on/off during testing ?

I went through the code in the mm/debug_vm_pgtable.c and saw that most
variations are related to the huge page support which xtensa doesn't have.
I've tested it with and without CMA.
I haven't found anything else interesting that I could tweak -- have I missed
anything?

-- 
Thanks.
-- Max
