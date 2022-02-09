Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8B0C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 07:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbiBIHuk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 02:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239675AbiBIHui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:50:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0977C05CB85
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:50:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z17so1510285plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 23:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QqKVxwbotUmQ2gv29/Ifw62O6CKJJcLZd1ZfJrEloTs=;
        b=YrWjB/wG3IOXIY6Z8JgawTYjBigvmgVdhNxoOC6JtZGS5wUpjHQMgB8hEh4plHCPcv
         jXcTLiXf2wgz3aDWwUYjVnjMQcuvAMTQiQJNRfbXibWcRZ9Kv++RjTlx5YFTSOnHIYCI
         oNJ1TZTXbkrwPGJGBbV4w6V+55Xk5lr0LnZkfb9Eg4H5E2oWF+4BOGo+CBdd9i9Erhtw
         aTqSz8gPPgG/JPNCDBtztu0KB3Q3Lxckl1pEL0SxI8RlzGXh6Q9eqQr1MIPZ8mq7WTGj
         WLnb9xw0aaeTmQfF3tiQ7PuwYsAYMasTK/AnTWXxnNkryOLnOecnydN+r4mazZFP9SmW
         N0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QqKVxwbotUmQ2gv29/Ifw62O6CKJJcLZd1ZfJrEloTs=;
        b=A7299DojHg4ZylHPhqKD5IpMgIAWLpn1e2sN0w/arASh2/GFA/yjZbJ67iDKAc7SdY
         QeMPZbN1Ayo94KDqEqPQG4Tw0niM68FW9jfDHK0KE5gLAETZ63J5D4QiGrW6RTsQ/15L
         35A7IfXQFLKWcc3Sk7F8fzCgSzxYrxS7wajzXqmgA+odtwf5E8luqMYHHm3k2lT9/fnx
         WBnAuoPqmns2JzuxK2sh+dhk7TMJmO85qpzgxwRsoVd936M251iNhG7+wyBSOwodHsyc
         hsh+FJjU0Px6hwQbwS2/mueJHfrraA4VwI12CuInReYgIlar01XGSwQpQdung2+oSqoF
         j4hg==
X-Gm-Message-State: AOAM533La+7dR2M5NEQgm4jZ+aKGmxZtVcWznL6d+2jW4ZEUCe9NdISG
        sS+fqAJmPbxn2QbgLnTQu7BD4Q==
X-Google-Smtp-Source: ABdhPJxHZmmgiaaNf2b9aVXUBOyF81jNaxOQCqlMvp4GxTrwPFzrUzWX5hCSHHRS8CqFK6TypgkHHg==
X-Received: by 2002:a17:902:9694:: with SMTP id n20mr992799plp.125.1644393038849;
        Tue, 08 Feb 2022 23:50:38 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id p1sm19731256pfh.98.2022.02.08.23.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:50:38 -0800 (PST)
Date:   Wed, 9 Feb 2022 13:20:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: Reintroduce ready() callback
Message-ID: <20220209075036.rpgzynwyjnfkbsbz@vireshk-i7>
References: <20220128032554.155132-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128032554.155132-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-22, 19:25, Bjorn Andersson wrote:
> This effectively revert '4bf8e582119e ("cpufreq: Remove ready()
> callback")' (except the Chinese translation), in order to reintroduce
> the ready callback.

I have added the Chinese translation back and applied both patches. Thanks.

-- 
viresh
