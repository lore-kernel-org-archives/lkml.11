Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46507C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 17:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbiDNRLA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbiDNRHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:07:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DAC24947
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:51:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so11196220ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=XOd+p86G00lunlXk7UiHmgo7WyOO3mZyzWAm62f9218=;
        b=dIGE0xRWthwh4l4lBoq+ZWVv0iTqfivf6+kURsN5+m+SIECtzVltOeXO9d1caKoO2F
         G7uxzZU9JqU3ehDwGLUlOjxy4zjipGfJv66XIFtKL9eJrfkzGvDVeEtLNFixl0I0tD2V
         uSOp3KVfdgo/z5ewSoNAAj5M3A46EPXx/7TZo32jYhXoy7rQ/OrVNnICC+UVT9Pytq4I
         COfIUjzA1UavyGN+T8nSwOK+gTwWF7R1Ow50mrZOxBOwlU/XvmPef6zM8FTrxdY6TUiv
         9WFBA94jiVGaVYjLFhjDQCPmkXxPn/cX2O1TUqSZDtyPjXUpZr25vCrPIHk2RIP8rdqg
         7nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=XOd+p86G00lunlXk7UiHmgo7WyOO3mZyzWAm62f9218=;
        b=Owv8R13UKsBkN+lQw2lBgO/PeDA/IbNeR1AfxgSvXkrAEN505lCGoUs9fUmolwYwCf
         LsMRQbd2paHqwVOmVT3xo9EBbcbBBLALyJpgUc3l9baCQe6hliKGEIvHrAoJOJq/1GW1
         TPw2V0WwHur7RT15PXOweuNYcNJE1i4K9Z8FUUZhHRVUMAp43RBPxm/2Ny96sRaU4myw
         0GyGhoXdutbwd+lFpoGJ4MGptUCcOrWKuHKaxb+GwbHWaOpgLSyu8Rx8A2BTZfmT9icY
         h/AVSepUBRyowlMG4+K7q/ijQuTvvyzFufi4mL5aBOd4nfAeIbC8uC4rUpU1ueLZuinB
         aTAw==
X-Gm-Message-State: AOAM531krg2aJXOspIUmvYKQ3rRtasyMZ3IsQgOAigZjGSglt2AwMqHS
        1LMA965IGgZCc/+wQqRAdqh2umyGB94=
X-Google-Smtp-Source: ABdhPJy7rPm4DnN167lmeS6GOnuyeNcPRrLtsIL50i5A4PcUOk72PYzZ9VUXLri/TrGJv1HvhE3APQ==
X-Received: by 2002:a17:906:6a15:b0:6e8:aa5a:f386 with SMTP id qw21-20020a1709066a1500b006e8aa5af386mr3186127ejc.649.1649955090858;
        Thu, 14 Apr 2022 09:51:30 -0700 (PDT)
Received: from [127.0.0.1] (77.119.216.48.wireless.dyn.drei.com. [77.119.216.48])
        by smtp.gmail.com with ESMTPSA id gl2-20020a170906e0c200b006a767d52373sm778124ejb.182.2022.04.14.09.51.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2022 09:51:30 -0700 (PDT)
Message-ID: <9c1e7a075ddba2037af5d6ba0a002363@swift.generated>
Date:   Thu, 14 Apr 2022 18:51:20 +0200
Subject: AW: your-internet.de
From:   Gerard Scholz <gerardscholz1978@gmail.com>
To:     "" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guten Tag


your-internet.de wird nicht mehr ben=C3=B6tigt, und desha=
lb zur Feilbietung ausgeschrieben.

Ihr freue mich =C3=BCber Ihr Feedba=
ck

Mit sch=C3=B6nen Gr=C3=BC=C3=9Fen

Gerard Scholz


......=
......................................................
