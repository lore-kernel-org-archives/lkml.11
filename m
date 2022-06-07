Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060E8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244391AbiFGNC7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiFGNC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:02:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A55712747
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:02:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id s12so27844296ejx.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBAPBWQf7bsWIM/4567gDBghNiToioCbV6qlqQR50IE=;
        b=OT+kV986wrjlyG5A3563I0PsfN8ar2tPHfFbfeIMGQj5cM4EkuJ85aSaPsz3X+jFbs
         5Hl26oH02RBZ67QjLH3eFdutFJLu0vE9wHc/sos+jY+lJOkksVd/3XGi525lV3ePQwT3
         tVRJQWlCfGREhCBZA5BvutVdIH7PjhnWaXGWcUehl226wbbJYKHIZFK84PyzOey+yXRq
         WfMSIfgz6IRY0qZpzbT5tiF6GUCvwextRuHYhf6MiVKFw23gsWVDajzpT6yiuYUxRMwJ
         mEljkE0TmXQi9quPQ11u8ckt+vtjOj18lECEGqUFZ9ngeIqqVxFR4D/HF2TgYU599N+I
         zL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBAPBWQf7bsWIM/4567gDBghNiToioCbV6qlqQR50IE=;
        b=aKcS1Fzr4jGBZdVjMdySyDp2GE6tenlulX5jOyJYjXk27hdVvQPlpJYYuINXGUq/y6
         nqTGG7eii4hesp9FTtZJ6Cdyqx1AyMXXJmxUkMVQAu05C2mYA/wBUuogbVVAgieyhkmE
         7PxulN4dsq6RI9aE6rguMrxx7xgoM0h+ezRk/P/6A9nO7VNVmgpyM9Arf94f6ovZKgsO
         x5eTJ9LV4I5zVYRVMJfqvupw6GNGegRVCmTigQahKwMeKB/x/TtpK3DBO9DpEZkiRI4Z
         fquEuZ2iIhqzq1VGHCGGM5HgFK+yB/seW2WaIQcxNpJOQw0FMETpw0TvllDFFSALsr54
         ye9g==
X-Gm-Message-State: AOAM531RnCQ7OsW65bXNgczQaep40+dwOpIYlw+crkDt2Or9V/oxfK1B
        NgBxmR5+5TNHNxd9nhtpJiCzzDkCvlejfFmpcsY=
X-Google-Smtp-Source: ABdhPJwogSbzt92JF6FwrbwYRbZwWsQVfNnGp89cOXlkV67J/FcJoO4bVQot8XM1emIjITJkZbAsx3kTsYzV0SjEOQc=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr26088882ejc.579.1654606974834; Tue, 07
 Jun 2022 06:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093449.3100-1-urezki@gmail.com> <20220607093449.3100-3-urezki@gmail.com>
 <Yp8fRttJPpZ+0+gu@infradead.org>
In-Reply-To: <Yp8fRttJPpZ+0+gu@infradead.org>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 7 Jun 2022 15:02:42 +0200
Message-ID: <CA+KHdyXMhH1uf92Pv_6H1Qar4BsTdfykdr3jC=KwG8Fe6Je=PQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/vmalloc: Extend __alloc_vmap_area() with extra arguments
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Tue, Jun 07, 2022 at 11:34:46AM +0200, Uladzislau Rezki (Sony) wrote:
> > It implies that __alloc_vmap_area() allocates only from the
> > global vmap space, therefore a list-head and rb-tree, which
> > represent a free vmap space, are not passed as parameters to
> > this function and are accessed directly from this function.
>
> Yes, which totally makes sense.
>
> > Extend the __alloc_vmap_area() and other dependent functions
> > to have a possibility to allocate from different trees making
> > an interface common and not specific.
>
> Which seems completely pointless.  Why add argument that are always
> passed the same values?
>
I wrote about it in the cover latter. It is a preparation work for
making vmalloc per-cpu.
In that case free/busy data are located on different rb_roots that is
why those functions
have to be adopted to work with any tree.

-- 
Uladzislau Rezki
