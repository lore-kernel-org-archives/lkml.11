Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF640C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381359AbiFQI7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 04:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiFQI7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:59:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB7B377EE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:59:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c4so5926101lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TNJPOvqpvLagogQrvAiixWYiTcMoGzNoekIPuHssDkA=;
        b=CA9F+WCKjwXAHY0Ubo0duZcqlgvFpybsPyEZCdXfd902XsdaMYDcMk8LM1cfgeDgcr
         d2H6pLqxTf4IFJxPnJTrVMzGLgx73ku60HWFhSHZW0CpJQKVM7eloDEa+fhlwse1vmC/
         zOnupAAF5wOlxs4Yj8y2Mp7sKmgXG4fRUdTL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TNJPOvqpvLagogQrvAiixWYiTcMoGzNoekIPuHssDkA=;
        b=VP6gMEP1uPhvYCrRbspSFunGhL6MMQ1tgSMGv21Fxshy48pCaXuEBcJvWP0gVN+f2Y
         6/bigsultHnqoMbD9yeaevWA1ruErZi32N/WUEAwBahN/WpgTd5+mBNKrvwFA+xoyBio
         IiUwUFO0ilbl9lY05/aN7byNCbXb8SjWwH7Eqk7B7A+GSJx4Oxgd19kXmgc7fikFw4n4
         oxPTpOJBBYl1lkWTqp/MIFTP6m5+jTpE9Gqt3aNQJkm5ETm2zAYhQGJ2quFM4PbKDJYX
         MihmETqaLEh16gutE7PLnaZFiYTyFwy/cnCLvyAwmQ6T0KB+ntLwwJu8TcYilcH7ZkvJ
         QFSA==
X-Gm-Message-State: AJIora9G3yYv/g0FapRwpz4dKsFwGKvyu9ZWez18g4wJahgDKCW6WB4s
        5XyDtEF8bWKTfj8E+jDQdTPAMXclmGJXZvJz
X-Google-Smtp-Source: AGRyM1vinlMEoex9SX+MRbPOhv00ibNgoAF7im+8kbyq/LF7OjTic8AX9sr3Kla4dysU2JTRY0jYEg==
X-Received: by 2002:a05:6512:693:b0:479:892:3091 with SMTP id t19-20020a056512069300b0047908923091mr4951806lfe.122.1655456344005;
        Fri, 17 Jun 2022 01:59:04 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y15-20020a056512044f00b00478ebc6be69sm558606lfk.261.2022.06.17.01.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 01:59:03 -0700 (PDT)
Message-ID: <0b4a9ba5-ed0d-e1a5-4982-8bad3e93f9b3@rasmusvillemoes.dk>
Date:   Fri, 17 Jun 2022 10:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 03/33] vsprintf: Convert to printbuf
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     pmladek@suse.com, rostedt@goodmis.org
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
 <20220604193042.1674951-4-kent.overstreet@gmail.com>
 <bc5daffb-e144-2a43-4657-eaf663e94750@rasmusvillemoes.dk>
 <ba8d21b8-7aae-6bfb-3553-3baba2bbeee1@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ba8d21b8-7aae-6bfb-3553-3baba2bbeee1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 20.44, Kent Overstreet wrote:
> On 6/15/22 05:09, Rasmus Villemoes wrote:

>> Anyway, my main concern with this is that performance goes down the
>> drain and the generated code will be awful. Have you done any
>> measurements and/or looked at disassembly? Thanks to
>> -fno-strict-aliasing (or perhaps just because we're writing through a
>> char* pointer which IIRC may alias anything), I think the compiler will
>> be forced to reload prt->pos and prt->size over and over and over. I may
>> be wrong, of course, that happens often. Perhaps __restrict could
>> help, IDK.
> 
> If we care that much about sprintf performance we must have some
> benchmarks somewhere - could you point me at them?

Try 'perf top'. Or copy the meat of vsprintf.c (all the %p gunk can be
elided) and do some measurements in userspace, that's what I did when I
improved the decimal conversion a few years back.

And yes, "we" care about sprintf performance because it's used to
generate all those files in /proc, /sys etc. etc. which many tools (e.g.
top/ps) rely on.

Rasmus
