Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E971C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 09:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiGFJkz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiGFJkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:40:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B30725C44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:39:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q9so21194256wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ErGLk8+0xCu5WgLQ3bfjqxCtN8t8ZPaM8b1famx/Fhc=;
        b=NISUS53ui9lqHhMNJqxRViQAmHoCdqL2kl3dzcfsZmvR18jOqIZkYtwHGH6371s6Zr
         SG/9nWcyU53biytlJ7pXpgOXd8AehqfqD0aZeLzlsZcSbIn4PNwl8/6+HBXGlh4OxKvE
         76v+7HdnNyLVl66N80XQQoB4iw/kdBo7RQNgT8B+e7Ydq5jumaKh3PAzzPKO7TBoW8gM
         1BYr8bZweqgS5F8uBNraXwcEvg6CNL14/93mGxIL2sreRbLYDeB0Q/lhpWZ9mcCuMBrp
         DQkTRCYrG/TF74OGdXob3+G/GaMAyu5njiYed9G4v40fWB6+3r+yPwKYyZ0kuxuHe5Zl
         MOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ErGLk8+0xCu5WgLQ3bfjqxCtN8t8ZPaM8b1famx/Fhc=;
        b=ZlVJd1tRdfswaJnLf4krQw/RpBq9Dul75Id+Dx1gJcadXIqLxPW5NS0AfohsxU01RB
         2HkzYtQtrfc8vh1s26RBVfgZ6j4ORtB/aGErtfscpGzqRNXsmomaPEIBLwgko6tSt9L7
         K96FhQpEuPBxzXQlN1xIgvBv0mFTGYKc5EiUF70/pNemg8SdKnB3EYlL3FRKtK7GiV/6
         ZDR14xk+rdwvyPDdXzW9q4YxJzl35ZvsbkD/udaLntDqq4VqCD1M0oITJ2J5QYKqw5d8
         JJ0SuU/uR06AHHw9ZLyhjRXjigxK8mAFHHRVKckilMAhueOyPvn3E4SVJwD/1+Edk+z4
         N6LA==
X-Gm-Message-State: AJIora9i0yJlsSHz1VLQTgUiGLyQsJ6IwFqPAITfaxFBYVjux1mzzAIt
        s9gyNjdwau6DhjMicB67/7XB2w==
X-Google-Smtp-Source: AGRyM1ufXZJBseWnCkHVYra95dQ8hroZ4IoSqEvEkNuJeGFsBw2JN6YWKeUBiI5yI2af5FOZlag4mg==
X-Received: by 2002:adf:dc0d:0:b0:21d:ea5:710f with SMTP id t13-20020adfdc0d000000b0021d0ea5710fmr36516555wri.48.1657100354526;
        Wed, 06 Jul 2022 02:39:14 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6286000000b0021d6e14a9ccsm6036070wru.16.2022.07.06.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:39:14 -0700 (PDT)
Date:   Wed, 6 Jul 2022 10:39:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v2] fs/pipe: Deinitialize the watch_queue when pipe is
 freed
Message-ID: <YsVYQAQ8ylvMQtR2@google.com>
References: <20220509131726.59664-1-tcs.kernel@gmail.com>
 <Ynl+kUGRYaovLc8q@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ynl+kUGRYaovLc8q@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 May 2022, Eric Biggers wrote:

> On Mon, May 09, 2022 at 09:17:26PM +0800, Haimin Zhang wrote:
> > From: Haimin Zhang <tcs_kernel@tencent.com>
> > 
> > Add a new function call to deinitialize the watch_queue of a freed pipe.
> > When a pipe node is freed, it doesn't make pipe->watch_queue->pipe null.
> > Later when function post_one_notification is called, it will use this
> > field, but it has been freed and watch_queue->pipe is a dangling pointer.
> > It makes a uaf issue.
> > Check wqueu->defunct before pipe check since pipe becomes invalid once all
> > watch queues were cleared.
> > 
> > Reported-by: TCS Robot <tcs_robot@tencent.com>
> > Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> 
> Is this fixing something?  If so it should have a "Fixes" tag.

It sure is.

Haimin, are you planning a v3?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
