Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC59EC3F6B0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 21:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiG2VmZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbiG2VmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 17:42:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894918B48E;
        Fri, 29 Jul 2022 14:42:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f7so5945560pjp.0;
        Fri, 29 Jul 2022 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7BOFJSBW/L3dYK23KQL3lApyWYMC+10Hhf7Pyqt3ybE=;
        b=UsSuUxJVjd/rI+hH+IVyDe3KlVwNgkNIeQR1fFovmH2W2ySjrXwR/MehfZScXQZtk9
         OrkYf0R5gCVvDIbF1qzpYVwwFkNiH2N2FvQDV5ka2B79WiwqvS8K3LfbBcBfyb+KnukZ
         G8xVjZuwkh3nAe9N6JdQUvZArW3zj99C0jIsv+vzLvhEHPl6vedU9K96H9i/hVAlrsVo
         kZWAXeSnzpN6oO/23/Mg2hyeaTyP2AK5+sgQDb1MExvVRg9NvJiW11eEYZ90/cVCUNZl
         ZFCZa3uHxp/aRM78go5jgnLXo+Mc4kNaHN+t3ow4C2PTawYA5UKjIhhIvseby4X71RY/
         EM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7BOFJSBW/L3dYK23KQL3lApyWYMC+10Hhf7Pyqt3ybE=;
        b=JF6lUaWP/iJAhWFrbrzxwgr2RCO5A5Opns62N/vpS6S2RqxLZwN//ulvEfN3AgxLX1
         mlpzE7i77F02TutsS+uCMyyiXIwsw6MT73DNWCh/Nzb7oabhXprNzLoqx7FpQeGQ38qT
         psTmczAf/UfYVgYbhPL5aQTV2Plrs/Q87dWw+H/jlPy7SLPQnaxqLPgMGQE4IuJEPfzq
         Am8i7pSdDqtIKlTuXdOK+4ZmpAR/CpHyZFylhp68Lo6+YNBYJlac04Z/LH2wfB40aGKK
         ONlGcf3QCpsUEI2Y3n9DlxAKhPX+t5mGiUTxlIsu1jlLCuVnQ3i6olK47MjjRv+id+gE
         sqsg==
X-Gm-Message-State: ACgBeo2nbA46d36FmD0ehgp2JNg9CYyLh06+qobXfHtb5XgTBCJI4WjB
        Tr+hFYin2Kb+bsqDNmxQy1o=
X-Google-Smtp-Source: AA6agR4HS/z9OnLCVyXhdRwjhwNRcfX281spXK9J2drfkrzXHgcukhzC7dGeyXUayjggMgXJ+RvkWQ==
X-Received: by 2002:a17:902:eb8a:b0:16d:bf08:9311 with SMTP id q10-20020a170902eb8a00b0016dbf089311mr5873256plg.139.1659130941060;
        Fri, 29 Jul 2022 14:42:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w21-20020aa79555000000b005252ab25363sm3316397pfq.206.2022.07.29.14.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 14:42:20 -0700 (PDT)
Message-ID: <6f35dac5-ef1c-a01a-f52f-ee8b8693b4cb@gmail.com>
Date:   Fri, 29 Jul 2022 14:42:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [net-next PATCH v5 13/14] net: dsa: qca8k: move port LAG
 functions to common code
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20220727113523.19742-1-ansuelsmth@gmail.com>
 <20220727113523.19742-14-ansuelsmth@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220727113523.19742-14-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 04:35, Christian Marangi wrote:
> The same port LAG functions are used by drivers based on qca8k family
> switch. Move them to common code to make them accessible also by other
> drivers.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
