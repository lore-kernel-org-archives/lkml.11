Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8008C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Mar 2022 06:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiC0GSl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Mar 2022 02:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiC0GSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 02:18:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8BCCC;
        Sat, 26 Mar 2022 23:16:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x2so12142266plm.7;
        Sat, 26 Mar 2022 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FFXAZ+ZCLg1E07+7aFn5xO35cDp1vs/vKSMlzwaorB8=;
        b=Rty7PjuEP4K8mBkWYBe2djpwG0fYPjUVS1Uc1H9kROTxTAzED0s6oPHAhhspyV58H7
         QiIdK4it5w0iWaA5W0KBKitGH7Sb9pVn4/Xf5q28ewpipyL3ti54EQzltsVKvdu3Hmk1
         88+w0ChS+j+YQ7bCW6AafREYI6vOru4zx4n57XDFTL8SiKmAWv7O8nHJd9M9qCqm61Ie
         JEg5Ppcde1b9zDfmCmi82p5HdPoS4RYYPIjRPWB9cq2YK3AkQD5R2p+ZWh5uof141lWj
         A1hQpFlqV4aJsd0NsdWU7MCYq7s6em+/1pmnjonJlX4Rc7k8TvXWRnF467MzK1zYjJhR
         zx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FFXAZ+ZCLg1E07+7aFn5xO35cDp1vs/vKSMlzwaorB8=;
        b=WSv5EavR2YFHQP1agPQpV1Vao5uHQyX7SichNxyYINypfL8vsqGBGkz2yyHYrczrmV
         WTZ9NDENi7RmzDmi9OEMFON3FjzHZ0POJ29d4IIOpead9elbNrswvKZOzCPu8tgIc2+Y
         P7sqwSZh+foR23Qo3jVSHhOLaM7ZOno+kss7tvSj6wiuTcxgUwkOP+ygwQyWYKHoSUD9
         R6aXcXJzZ8zTl60t2IOSDqZEhL5dNU8Wa3lzzdtQTAqY2ip1QopRqM45JMI6lg7COHwB
         KZdvj5mZnZoqp4jXUbq9hEmB40YWFG6zba081LXXBxNmEtAKKVMKEMgN4opGoeXtgo4o
         WDOQ==
X-Gm-Message-State: AOAM530rO2S5wwyZtCzH3R9Tw+a9owDN/5xK6GzONLWAKmJdCEXQXD4M
        rPqipPj4eUzlp1GoIP7L1UQ=
X-Google-Smtp-Source: ABdhPJwK5F1pt++klpew6iP/jI6WmfaSJ7D9iE9lboar4F92qzgiXyRBBeauoMsJ4lVYhUnpZRtivA==
X-Received: by 2002:a17:902:d2c8:b0:154:2b02:a499 with SMTP id n8-20020a170902d2c800b001542b02a499mr20134427plc.168.1648361813442;
        Sat, 26 Mar 2022 23:16:53 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id kk11-20020a17090b4a0b00b001c73933d803sm17608212pjb.10.2022.03.26.23.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 23:16:52 -0700 (PDT)
Message-ID: <bd8eb95a-1af7-1925-d3f2-0baa91b55526@gmail.com>
Date:   Sun, 27 Mar 2022 13:16:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] docs: Add a document on how to fix a messy diffstat
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <87wnghd78t.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87wnghd78t.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/22 04.58, Jonathan Corbet wrote:
> +So what is to be done?  The best response when confronted with this
> +situation is to indeed to a merge, but to do it privately, as if it were
> +the source of shame.  Create a new, throwaway branch and do the merge
> +there::
> +
> +  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
> +                |         |                                      |
> +                |         +-- c1 --- c2 --- ... --- cN           |
> +                |                   /               |            |
> +                +-- x1 --- x2 --- x3                +------------+-- TEMP
> +

A merge from the mainline, right? Or merge from what?

-- 
An old man doll... just what I always wanted! - Clara
