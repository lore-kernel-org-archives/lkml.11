Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A91C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 07:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiEWHgx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiEWHgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:36:05 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0238F15712
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:35:53 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e93bbb54f9so17367206fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfc8r7NT7wtvHcx6MP/0oIdg3AV2iAuRw51nic1YztY=;
        b=IF8vzXzDNvZ4rrYYB7Wnh1QmvqH6Ii3XDGg2N4qU66JB8ffmqQCPeMp3xsuLsQbFQk
         SC08EQX+pXfLPvPlLJE7dSr0gAl2sz4WoA4VAOun8qM3teWALPzfgQMXd16hFc350JC3
         jUiniHXxD3QaTJA90Tnd1LpJIPdZqxbvEMdyYZohJ46QT0IlQiC7uGbHYCpjvX5xq4lE
         xaqaSnccVMqKdmsgLa+z34FedxIrA0JVxn6hu92H2qtYeMHlKP0hzPWKK22qlkh9pCKT
         IIvK27YKjLintPOIVBoEfqktJxEto8ICPMWFRyb/60Vk5OzNLiC8IVbbAk5vrPyUsaYe
         7UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfc8r7NT7wtvHcx6MP/0oIdg3AV2iAuRw51nic1YztY=;
        b=YL9AgeOCOPYsaQcBiRpQ6jIjjnNvV4jRvFXGu/jGg5IUIFlsQsp9+/49qC+UDmUbSc
         gQRJqSukFZfzuHdDfSZuomA2VhJQmSynUooKH9aYSgibdtsefo+GZOmt+Ondrdu/gR8q
         xu/ebNpVG/TnLQ1psrY3h7s/3yrQcUvG5Yl9QO3O1+r0yQK9Js+Ta66xJleHDq2ZuwM0
         F4pMI09wSk+eklLVt3EqRJPNR89EIV+7J6tpq1Xv9OabuqBMEqr8x4ja8gtOOEFzunFs
         gJZNhhxMa3bdP6W/9UO9+10vMaNp1YU7o5HwyFNo5vL+HrLs4u0ytB10/mhJ5cBXcXjZ
         gZ3g==
X-Gm-Message-State: AOAM532xnAFM7kNi1Smk0qRAZ6eRdS40XkXBD04y4HZ0I+Fek2yX+D5Q
        KbzJDOqfOMnPk3Q5gyitqXcc3fLBFk22OfyNge8=
X-Google-Smtp-Source: ABdhPJway1RyrqBBM8d/G7eojoKeL0ABEU72UVGF95qOE7EdgdTeRttJIdINJm+pu8iclI8IuHQ235OS+F2YbubXC7I=
X-Received: by 2002:a05:6870:d152:b0:f1:b21a:a168 with SMTP id
 f18-20020a056870d15200b000f1b21aa168mr11071169oac.55.1653291352708; Mon, 23
 May 2022 00:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220518230953.112266-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220518230953.112266-1-yang.lee@linux.alibaba.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 23 May 2022 00:35:41 -0700
Message-ID: <CAMo8BfK5TEPmMurtA9cNWPV__ws8Ok=6vqsdaO4mJ=G_6-wP2w@mail.gmail.com>
Subject: Re: [PATCH -next] xtensa: Return true/false (not 1/0) from bool function
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 4:10 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Return boolean values ("true" or "false") instead of 1 or 0 from bool
> function. This fixes the following warnings from coccicheck:
>
> ./arch/xtensa/kernel/traps.c:304:10-11: WARNING: return of 0/1 in
> function 'check_div0' with return type bool
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/xtensa/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks! Applied to my xtensa tree.

-- Max
