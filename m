Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37468C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 18:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiCASqm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiCASqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:46:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7FB6C93B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:45:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso2668699pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7uGWoF4BIX4G7uGlBaz7mIppQlmmmgZ3uVpE0YdxbE=;
        b=Rnkv/AJd+5iy30mZzep7QXo8K/F/3SaVyLdc8rbCGNMsgsFv5IBT1c+gvLBRE6ku+w
         UwW2B20QOyzUAV/WYlAr69F6Ds/mAVIdJyKKpuGlLqQmrX0kscnL0Ee1JYzrWtxMXuxC
         HuFImbbTD3Ptoddk79DLRbZ5xEvhH6hzEqxwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7uGWoF4BIX4G7uGlBaz7mIppQlmmmgZ3uVpE0YdxbE=;
        b=yTvaE3VIZDbjQwUSqaU3P05qQSsfYH779KzFBCshKOf6fbx3ne278Dus96ZfNQ46y7
         u5hWwZNo3hrYkjPDUvZo2fR7UeGwUyCGsLTxef5NypAazvkxL/8pFschYj9a/wrQacpR
         qAY6z7zzQ7VC8Y+D6h6CQlfYtSlNAy+23PBjmVdb1ITJmcxtF5B54PGfEtalDRHjvF0u
         99FJPwUpQv2crnfl14hlqs2VayV0IvgCaZSiWCserLsgk8diIaxMtWVUV6+d67iEj2ci
         tbBWiwegsh86JfXkJMTFhu47IuTBcVwvD/K6+A5LFFNJnd3U6v8IsCpha18jY3yoHVZo
         e+9g==
X-Gm-Message-State: AOAM530UwrrhVXq16A/bCjovRTBjCDS998VRZHMWjOYQJS3123GkRk/E
        tv+I2u7ABNb9Yo0HHxjOTij83Sw0k7BybA==
X-Google-Smtp-Source: ABdhPJwvOdWv01gPbRHR1OBf3NvUx40QddL/RHLUdjcrmlX0gFA3xiuZ8QxXRNylsIMqUzXgvA7RiA==
X-Received: by 2002:a17:903:1206:b0:151:7d67:2924 with SMTP id l6-20020a170903120600b001517d672924mr5587186plh.45.1646160299905;
        Tue, 01 Mar 2022 10:44:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a0002a700b004f357e3e42fsm17323387pfs.36.2022.03.01.10.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:44:59 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Anton Vorontsov <anton@enomsg.org>,
        Tony Luck <tony.luck@intel.com>,
        Colin Cross <ccross@android.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Kees Cook <keescook@chromium.org>, kernel@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: Add prefix to ECC messages
Date:   Tue,  1 Mar 2022 10:44:35 -0800
Message-Id: <164616027128.2800203.5940158670244885252.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220301144932.89549-1-vincent.whitchurch@axis.com>
References: <20220301144932.89549-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 15:49:32 +0100, Vincent Whitchurch wrote:
> The "No errors detected" message from the ECC code is shown at the end
> of the pstore log and can be confusing or misleading, especially since
> it usually appears just after a kernel crash log which normally means
> quite the opposite of "no errors".  Prefix the message to clarify that
> this message is only about ECC-detected errors.
> 
> 
> [...]

Excellent point. :)

Applied to for-next/pstore, thanks!

[1/1] pstore: Add prefix to ECC messages
      https://git.kernel.org/kees/c/023bbde3db41

-- 
Kees Cook

