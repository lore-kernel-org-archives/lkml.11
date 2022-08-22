Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918CBC28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 20:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiHVU5q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 16:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbiHVU5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:57:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF3E52464
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:57:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gi31so17161719ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8+w/4wN4Kn9IuMC++iFFlzp2WwbxqZ59X9FUeGfwhBk=;
        b=fYYniBxHiVwcF2BmK3KQ22wU18o0DH33kdvQM6owzc54phQZrADAhsB0KUNjBTW/4n
         KFBdJhx6Z5RaGTornUDAQGK5YUy58LxrDcvf420f1nAiTx++9ViqxzcvJqQsJNUw+OuF
         GihnHM+cOFx0Bv4xBwPad9Q6w8qsZXl+zK3E8dEzelty1iphcn04DW5GEBDCm/jMeb4T
         OCw+eBlz1p2gFFX0SxO7PjXrHiITKW14F8RKRy6DSuilWy1GqjXtCI89SfVsfhw9CCyK
         DGGfE9xAoFSC4CvnXV0F96uY1FSfdgkWzbv3QuRmkEntsc8VzqjjkBN3m9rUrHC9t1aB
         jtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8+w/4wN4Kn9IuMC++iFFlzp2WwbxqZ59X9FUeGfwhBk=;
        b=nE+aClZZ51ftq32wDQQZS64jKLFK5Efa7NTAgy0vvfByMQkbfZjKAk9n3WKF8YEqYQ
         Vb3EFNmU9BPSygdL+SllVEyuCfyavAYmdpVXUk0eGtX/OnpRqK8MV81fvEzniM+YiKuQ
         +sYG55k5xa1DlqFdAuNWqMW6LSUVY4A3pKzr4oA2i03mG4++unEUD9n1lBS2Xev70zTk
         efn8SE5LHkcS8y4z4K5tIascg7MjIEOyb4ARVD/od1FiLmmDYL5ocCW/SForfOTH/1aZ
         SbespPpXIA5LfHSUtwhWKE+zA6XyEs26lApUyW4MFgPrwST6hKFiWP6j5NlWe6cHloZ5
         j1kw==
X-Gm-Message-State: ACgBeo10TMBKgcjv7N0E88aywQhTY7PkQ/n/M1N3x0ReYGIs8CmGK0Qo
        v4o2zmlr3kzc2blGns2XHXHFJBIgFmwYcw1nWD4QTQ==
X-Google-Smtp-Source: AA6agR5pxXGlEMxNRs7Z2OKkdwJ6xNz0jSc1iyTiUnWSENLuvFQ1tVkv1QnGjApffh+raGhWW64rAVp/Am8ZXS94LrI=
X-Received: by 2002:a17:907:971d:b0:73d:78c8:77b5 with SMTP id
 jg29-20020a170907971d00b0073d78c877b5mr5455613ejc.631.1661201860966; Mon, 22
 Aug 2022 13:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220817164851.3574140-1-joefradley@google.com> <20220817164851.3574140-3-joefradley@google.com>
In-Reply-To: <20220817164851.3574140-3-joefradley@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 22 Aug 2022 16:57:29 -0400
Message-ID: <CAFd5g47Wm=CSa1T-ySxrvOsE8VzVwOstsfus=_52EX7gvLgvyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: no longer call module_info(test, "Y") for
 kunit modules
To:     Joe Fradley <joefradley@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:49 PM 'Joe Fradley' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Because KUnit test execution is not a guarantee with the kunit.enable
> parameter we want to be careful to only taint the kernel only if an
> actual test runs. Calling module_info(test, "Y") for every KUnit module
> automatically causes the kernel to be tainted upon module load. Therefore,
> we're removing this call and relying on the KUnit framework to taint the
> kernel or not.
>
> Signed-off-by: Joe Fradley <joefradley@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
