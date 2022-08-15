Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC52C00140
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 01:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbiHPBY4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 21:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiHPBYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:24:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338BBEE6BD;
        Mon, 15 Aug 2022 14:14:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x23so7416710pll.7;
        Mon, 15 Aug 2022 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=wcQ1r/sqg2CzoRZsjNTeLUUOzyl5NynlAfx/6TvShuo=;
        b=jfdRIc58wSKw5+LFAOD3R58oEgb8WlNSW6Yq/3GU4cMgOltcrqra8jsFDIYpa9grCu
         j6xLue9nuTgx1/xXYk1GJ4mEaPe1rCfHLpDwuyQCDIwXPPzNlE7/D7imW3J8mQdrg/vG
         lYeec4rF0VYtjQmQwLQg4mYI11EQ7rxYeCj7j6KRlJThxhbFzs9s9IdN4VuMmDr54mCw
         DxFtI7lvaMQD5noiZ+KNP9ggRXCUsmmWraIkDJ1AAiUCGscBJJR4+RYge0S36mQOqixk
         FjcSHuDaM38f9eJZw+nQsAm+77WcA+z6MICzr7FYbxiybVARFIOGETxwFVaLTRCWjA/f
         8QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=wcQ1r/sqg2CzoRZsjNTeLUUOzyl5NynlAfx/6TvShuo=;
        b=Mld2QIitNzcBASUDQpen5CzdyNN5YYahAJCLRemKIMhDKMsNejIoyxJMuzarPyhN5k
         9RmTZOs6xorp0o5Cuz60xZmw929ZGVMRsT17+iXf0X0DDC3eon9+dYVMmZeUhW/EO0iU
         m0aWz5/T15lAJNMCKOF+71+mMNAACdywSlYXDiu/Zs8kid/BCxmn+f+t/RBH1dQTyXSg
         0goloE3Oc6C44goE00VNlOxuCNuq3781g+gonZNvlhyJ8UoUrvSCizbPD0YuiZF+xXv1
         22BTlZEwHlt3WdChP1nB5aCDt09XUdJjxBLOUAVNd2GsLL/14ApzHykJDVs5Aq2itv6E
         AIXw==
X-Gm-Message-State: ACgBeo0pjIwH7lNlMcyA1r/tOwk9Y/9v9UClbD1e3APAZcZ5DgF/V7oe
        FBUZS3TJbAY1RUtR7RMBvRw=
X-Google-Smtp-Source: AA6agR7tyqf8aF+PTibUJNLOlk1vDgukJjxkk3/99RHrkgVyzm9T4WHBVDjh2q+NGKNb7I6rbzJ8oQ==
X-Received: by 2002:a17:903:22c3:b0:16f:2182:6f3e with SMTP id y3-20020a17090322c300b0016f21826f3emr18749047plg.59.1660598051842;
        Mon, 15 Aug 2022 14:14:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3a69])
        by smtp.gmail.com with ESMTPSA id d26-20020a65621a000000b00421841943dfsm6224115pgv.12.2022.08.15.14.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:14:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Aug 2022 11:14:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v8 06/31] workqueue: introduce `__INIT_WORK_WITH_KEY`
Message-ID: <Yvq3IfK4+C94AeE2@slm.duckdns.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-7-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802015052.10452-7-ojeda@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:49:53AM +0200, Miguel Ojeda wrote:
> From: Wedson Almeida Filho <wedsonaf@google.com>
> 
> A Rust helper (introduced in a later patch) needs to call
> `__INIT_WORK` with a passed key, rather than define one in place.
> 
> In order to do that, this moves the initialization code from
> the `__INIT_WORK` macro into a new `__INIT_WORK_WITH_KEY` macro
> which takes the key as an extra parameter.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route the patch with the rest of the series or let me
know if you want through the wq tree.

Thanks.

-- 
tejun
