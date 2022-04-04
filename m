Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5B8C43219
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355643AbiDDVVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380017AbiDDSk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:40:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1023CFE;
        Mon,  4 Apr 2022 11:38:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b13so9849861pfv.0;
        Mon, 04 Apr 2022 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nh9EyiWG8bH88pOKO/orB2F1BTvp8RdXpao3o9qIKVU=;
        b=WBk4YURv2n8mR4BnXBU5Co6GREGNq67cVLsjtFkSEOSQuBtp7c01VP50uOrhbYLJPT
         CqBeVN/1wSte8uHk32P8jXVsYJDeywIe9VkOv9ou4GlVC8eGl3s2vOZ6dPVd7to9PZ25
         GLuLtWi1rwnq7eIDsZnL7Az8zcZ5GoTEOIM+bO20cjKMWl3Nqu1t2ygB/trM1CuVEfa4
         64FbsfPid5Ruwn4bHoxZpxasH4CiFBp+dIpDSaYH9nAnLad99vgpaX8u6ZwYsmNPpptp
         KCoY+/7fArKV0uZq+VitvyHLN3VRfulzY5FPASlKrIKbzC8lbWPKpe1CwIaem7Q3z1yb
         JxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nh9EyiWG8bH88pOKO/orB2F1BTvp8RdXpao3o9qIKVU=;
        b=jmJIc982aPyUaP/zMxL2HSVke2YaJdblaEqdrPwcRFg/jQY7zVOYWaI5hwLI8UbPAI
         F+jpbWSq6Ahf1iZk5DuvEi+26c8MkXFHeuHZwy8WuoWHxnC+7DMBhML6/UWll7abz39e
         tiXlv3lkHZu4fsrUjzPigBlQzVO2obQEEHy6S4QhyKkSDkx42llgMnAr2zmn+npHvNIL
         EnR6KwDuT7FSUpdKBvlod4AWRCbkNzXNfoDaljYeONqOU2vuYhghhDCRPRVN57jAQZ1b
         73NxpTfwr3qZFJvv5Iumh4siciLhAAJ4Fupx82z+wvgGumrllwz/yhZAZLzguWN+wdEv
         IoBA==
X-Gm-Message-State: AOAM532BtKZqaCakuFiY7vW7IMpc/MACLM46xTyoJbGFdecWX4ofmYvM
        4aSiMvJHe9nXyUEmKYxyEkw=
X-Google-Smtp-Source: ABdhPJyNsk+WMwaHYVwRYd772qQ7duJlLvu0R5roVGPfesWBXzLoafNx4P3mRx7QfElxwmvfP88n9g==
X-Received: by 2002:a05:6a00:c8e:b0:4fb:18a6:18f9 with SMTP id a14-20020a056a000c8e00b004fb18a618f9mr1042559pfv.47.1649097509345;
        Mon, 04 Apr 2022 11:38:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 34-20020a17090a0fa500b001cabffcab2csm155161pjz.55.2022.04.04.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:38:28 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-9?b?QXL9bucg3E5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: bcm: add bindings for Asus RT-AC88U
Date:   Mon,  4 Apr 2022 11:38:26 -0700
Message-Id: <20220404183826.2317943-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402204622.3360-4-arinc.unal@arinc9.com>
References: <20220402204622.3360-1-arinc.unal@arinc9.com> <20220402204622.3360-4-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Apr 2022 23:46:22 +0300, Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
> Add Asus RT-AC88U under BCM47094 based boards.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
