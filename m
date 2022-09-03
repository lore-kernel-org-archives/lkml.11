Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122FFC54EE9
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Sep 2022 01:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiICB67 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 21:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:58:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4DE1146
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:58:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa2so3547192pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 18:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5H8pIAL+DYHHI5l4+Ml0i0IAndmMiHzeUh2KaNWL3RM=;
        b=LLioZ3j2yDGFcR6QQUlQVHz6Y2Ce0rdEnTp1iGZQ7X29fUkLT4JrFVhqr5xy/hTYtU
         zy7AMAHbWb8J7oZSai8aDQ0KaszJ4TluL/PaMkrGd+QSbTEpgxbvIZTCeElOl7zawLc/
         /s3OHTUhwY/94IU7a2+2suldH2mAddYNVeqtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5H8pIAL+DYHHI5l4+Ml0i0IAndmMiHzeUh2KaNWL3RM=;
        b=qrpk0JwpKvAIzZQKWNQ1l2z6rmGdmA+XtHSer7gpV9iyPsows/o0SZaJ/7BX/Os4Hk
         E7FNXqCLPRTHOl1EaPdkaWYESJEFRJ8GqZSGnfVYYGHwQJZGVg/RrKJDMQ0XvfC5nFVP
         QXqraVskgHVrd1K2libbz+A5fCpOd/NxgvKtLm5F9y2BGhOzcRAIfXsR6fzWn4IS3VAq
         o5nZ7cqylHoS2ooxTMGX9dO4V9XtcUKJfynYyaoeeOyFB2qAmWggXKe61ZFKvCYmtEJB
         QeBdmsC8Wxa656H0eKZGRn+RjaQ1NQmRs+v9xkjpNTnKcH5xtR0VuMNXrSMQtOCdrZ1Y
         iG7A==
X-Gm-Message-State: ACgBeo3Di0VwrsEcdWq23C4iXKU8TDk4HzwdR6uYO2vYeb11xgmteXGr
        yNLsIT5ERgaq3bMpHl4qhhj8pg==
X-Google-Smtp-Source: AA6agR4GORnA4Wx/SDGDcI7KhC4jQCnM7Xh/7FWJ/Vd80S4wEEiDytSWsuGjL2tMJv3TdH6pabpKIw==
X-Received: by 2002:a17:90a:b00b:b0:1f1:6023:dacd with SMTP id x11-20020a17090ab00b00b001f16023dacdmr7596126pjq.184.1662170333437;
        Fri, 02 Sep 2022 18:58:53 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id c14-20020a056a00008e00b0053ab9c18d3csm2631443pfj.14.2022.09.02.18.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 18:58:52 -0700 (PDT)
Date:   Sat, 3 Sep 2022 10:58:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        tom@talpey.com, Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH] MAINTAINERS: Add Tom Talpey as ksmbd reviewer
Message-ID: <YxK02EVt/7OWjfiE@google.com>
References: <20220903015340.7336-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903015340.7336-1-linkinjeon@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/03 10:53), Namjae Jeon wrote:
> Tom have been actively reviewing ksmbd patches as well as
> smb-direct patches. He agreed to help us as a reviewer,
> So adding him to reviewer list in ksmbd entry.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
